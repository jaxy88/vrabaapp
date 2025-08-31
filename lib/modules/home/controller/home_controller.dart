import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final _storage = const FlutterSecureStorage();

  onLogout() async {
    onRemove();
    onRedirect();
  }

  onRedirect() {
    Get.offNamed("login");
  }

  onRemove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLogged");

    _storage.delete(key: "token");
    _storage.delete(key: "isLogged");
    _storage.delete(key: "idCliente");
    _storage.delete(key: "typeUser");
    _storage.delete(key: "cedula");
    _storage.delete(key: "email");
    _storage.delete(key: "documentonit");
    _storage.delete(key: "razonsocial");
    _storage.delete(key: "clientename");
    _storage.delete(key: "id");
  }
}
