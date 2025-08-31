import 'package:another_flushbar/flushbar.dart';
import 'package:app/utils/constants.dart';
import 'package:app/widgets/count_down_widget.dart';
import 'package:flutter/material.dart';

class FlushBars {
  static Flushbar<void> undo({
    required String message,
    required VoidCallback onUndo,
    required Duration duration,
  }) {
    return Flushbar<void>(
      messageText: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 15)),
      icon: CountDownWiget(duration: duration),
      backgroundColor: colorPrimary,
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: duration,
      margin: const EdgeInsets.only(),
      mainButton: TextButton(
        onPressed: onUndo,
        child: const Text(""),
      ),
    );
  }
}
