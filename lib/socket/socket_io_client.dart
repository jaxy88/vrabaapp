import 'package:app/logger/app_logger.dart';
import 'package:app/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoClient {
  late IO.Socket _socket;

  void Function(dynamic)? onNotificationOrdenCallback;

  void connect() {
    _socket = IO.io(
      url.replaceAll("/api", ""),
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      AppLogger.i("Info: Conectado al socket");
    });

    _socket.onDisconnect((_) {
      AppLogger.e("Socket desconectado. Intentando reconectar...");
    });

    _socket.onReconnect((attempt) {
      AppLogger.i("Reintentando conexión... intento $attempt");
    });

    _socket.onReconnectFailed((_) {
      AppLogger.f("Falló la reconexión después de varios intentos.");
    });

    _socket.onError((data) {
      AppLogger.e("Error en el socket: $data");
    });
  }

  void disConnect() {
    _socket.disconnect();
  }

  void dispose() {
    _socket.dispose();
  }

  bool isConnected() {
    return _socket.connected;
  }

  void registerSokectID(id) {
    _socket.emit('register', id);
  }
}
