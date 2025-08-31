import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/constants.dart';

class Api {
  Dio dio = Dio();
  String? accessToken;
  final _storage = const FlutterSecureStorage();

  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  Api() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          accessToken = await _storage.read(key: "token");
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException exception, handler) async {
          final isTokenExpired = exception.response?.statusCode == 401 &&
              exception.response?.data['error']['message'] == 'Token expirado';

          if (isTokenExpired) {
            final completer = Completer<Response>();

            _retryQueue.add(() async {
              final newResponse = await _retry(exception.requestOptions);
              completer.complete(newResponse);
            });

            if (!_isRefreshing) {
              _isRefreshing = true;
              try {
                await refreshToken();
                for (var retry in _retryQueue) {
                  await retry();
                }
              } catch (_) {
                _retryQueue.clear();
              } finally {
                _isRefreshing = false;
              }
            }

            return handler.resolve(await completer.future);
          }

          return handler.next(exception);
        },
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> refreshToken() async {
    final currentToken = await _storage.read(key: 'token');
    final response = await dio.post(
      '$url/utilidad/validate/refreshTokenIfExpired',
      data: {'token': currentToken},
    );

    if (response.statusCode == 200 && response.data['token'] != null) {
      accessToken = response.data['token'];
      await _storage.write(key: "token", value: accessToken);
    } else {
      await _storage.delete(key: "token");
      accessToken = null;
    }
  }
}
