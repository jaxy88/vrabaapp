import 'package:app/connection/connection_status_controller.dart';
import 'package:app/utils/check_internet_connection.dart';
import 'package:get/get.dart';

class StatusConnection {
  final controllerConnection = Get.put(ConnectionStatusController());

  bool getSatus() {
    // ignore: unrelated_type_equality_checks
    if (controllerConnection.status == ConnectionStatus.offline) {
      return false;
    }
    return true;
  }
}
