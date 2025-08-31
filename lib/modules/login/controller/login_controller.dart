import 'dart:async';
import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app/modules/home/controller/home_controller.dart';
import 'package:app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Dio dio = Dio();

  final homeController = Get.put(HomeController());

  final bool _loading = true;
  bool get loading => _loading;
  late dynamic decoded;
  String opcion = "";
  final _storage = const FlutterSecureStorage();
  late SharedPreferences prefs;
  String idUser = "";

  String tokenFCM = "";

  Future<void> onLogin(
    String username,
    String password,
    var tokenFCM,
    BuildContext context,
  ) async {
    if (username.trim().isNotEmpty && password.trim().isNotEmpty) {
      try {
        var response = await dio.post(
          '$url/auth',
          data: jsonEncode({
            'username': username,
            'password': password,
            'tokenFCM': tokenFCM
          }),
        );

        if (response.data['status'] == 'success') {
          homeController.onRemove();
          prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogged', true);
          final id = response.data['id'].toString();
          idUser = id;

          /*    .saveTypeUserUser(response.data['type'].toString().toLowerCase());
          _storage.write(
              key: "typeUser",
              value: response.data['type'].toString().toLowerCase());

          final typeUser = await infoUser.getTypeUserUser();

          _storage.write(key: "token", value: response.data['token']);
          _storage.write(key: "username", value: response.data['username']);
          _storage.write(
              key: "email", value: response.data['email'].toString());

          switch (typeUser) {
            case 'vigia':
            case 'Vigia':
              Get.offNamed("vigia");
              break;

            case 'cliente':
              final id = response.data['id'].toString();
              _storage.write(key: "idCliente", value: id);

              idUser = id;
              _storage.write(
                  key: "clientename", value: response.data['id'].toString());
              _storage.write(
                  key: "documentonit",
                  value: response.data['documentonit'].toString());
              _storage.write(
                  key: "razonsocial",
                  value: response.data['razonsocial'].toString());
              Get.offNamed("cliente");
              break;
            case 'conductor':
              Get.offNamed("conductor");
              break;
            case 'propietario':
              final names = response.data['user']['auth']['nombres'].toString();
              final surname =
                  response.data['user']['auth']['apellidos'].toString();

              infoUser.saveUserName("$names $surname");
              Get.offNamed("propietario");

              break;
            case 'admin':
              Get.offNamed("admin");
              break;
            case 'transporte':
              Get.offNamed("transporte");
              _storage.write(
                  key: "email", value: response.data['email'].toString());
              break;
            case 'planillador':
              Get.offNamed("planillador");
              break;
            case 'recepcionista':
              Get.offNamed("recepcionista");
              break;
            case 'embarcador':
              Get.offNamed("embarcador");
              break;
            case 'contador':
              Get.offNamed("contador");
              break;

            case 'maritimo':
            case 'Director Maritimo':
            case 'director maritimo':
              Get.offNamed("maritimo");
              break;

            case 'supervisor-maritimo':
              Get.offNamed("supervisor-maritimo");
              break;

            case 'user-tarja':
              _storage.write(
                  key: "idTarjador", value: response.data['id'].toString());
              tarjaController.documentoTarjador.value = response.data['cedula'];
              programacionController.numeroEscotillas.value =
                  await programacionController.onViewAsignarEscotilla(
                      response.data['cedula'], context, "");
              Get.offNamed("tarja");
              break;
          }*/
        } else {
          showOkAlertDialog(
            context: context,
            title: "Notificación",
            message: response.data['message'],
          );
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      showOkAlertDialog(
        context: context,
        title: "Alerta",
        message: "Todos los campos son obligatorios",
      );
    }
  }

  Future<Map<String, String>> getHeaders() async {
    String? token = await _storage.read(key: "token");

    return {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
