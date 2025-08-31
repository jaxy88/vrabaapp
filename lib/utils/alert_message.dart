import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

class AlertMessage {
  void messageAlert(BuildContext context, String message) {
    showOkAlertDialog(
      context: context,
      title: "Notificación",
      message: message,
    );
  }
}
