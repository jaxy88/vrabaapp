import 'package:app/connection/connection_status_controller.dart';
import 'package:app/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WarningWidgetGetX extends StatelessWidget {
  const WarningWidgetGetX({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConnectionStatusController());

    return Obx(() {
      return Visibility(
        // ignore: unrelated_type_equality_checks
        visible: controller.status.value != ConnectionStatus.online,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 60,
          color: Colors.red,
          child: Row(
            children: [
              const Icon(Icons.wifi_off, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'No tienes conexion a internet',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    });
  }
}
