import 'package:firebase_messaging/firebase_messaging.dart';

import '../logger/app_logger.dart';

class Handlemessageapp {
  Future<void> handleMessage(RemoteMessage message) async {
    AppLogger.i("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    AppLogger.i(message.data.toString());
    AppLogger.i(message.data['type']);
    AppLogger.i("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    switch (message.data['type']) {
      case "notificar":
        //notificationSaldosPays(message);
        break;

      default:
    }
  }

  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token;
  }
}
