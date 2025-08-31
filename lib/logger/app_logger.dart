import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Cantidad de métodos en el stack trace
      errorMethodCount: 5, // Métodos para errores
      lineLength: 100, // Largo máximo de línea
      colors: true, // Colores en la consola
      printEmojis: true, // Emojis en niveles de log
    ),
    level: kReleaseMode ? Level.info : Level.debug,
    filter:
        null, // Puedes definir un filtro custom si quieres silenciar algunos logs
    output: null, // Puedes cambiar la salida (ej: archivo, remoto, etc.)
  );

  /// Logs de depuración
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Logs informativos
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Logs de advertencia
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Logs de error
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal
  static void f(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
