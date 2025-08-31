import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app/connection/status_connection.dart';
import 'package:app/modules/login/controller/login_controller.dart';
import 'package:app/modules/login/view/bezier_container.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/handle_message.dart';
import 'package:app/widgets/warning_widget_getx.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Handlemessageapp messageapp = Handlemessageapp();
  StatusConnection statusConnection = StatusConnection();

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;
  bool showTypeRol = false;

  List<String> listTypeRol = <String>[
    'Seleccione',
    'Contador',
    'Conductor',
    'Embarcador',
    'Planillador',
    'Recepcionista',
    'Tarjador',
    'Super Tarja',
    'Transporte',
  ];

  @override
  void initState() {
    _controllerUsername.text = "admin";
    _controllerPassword.text = "CADEGR##2024.";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  //_logo(),
                  SizedBox(height: 50),
                  _usernameWidget(),
                  SizedBox(height: 10),
                  _passwordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  SizedBox(height: height * .055),
                  WarningWidgetGetX(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GetBuilder<LoginController>(
      builder: (controller) => !isLoading
          ? TextButton(
              onPressed: () async {
                final token = await messageapp.getToken();
                if (statusConnection.getSatus() == true) {
                  setState(() {
                    isLoading = true;
                  });
                  await controller.onLogin(_controllerUsername.text,
                      _controllerPassword.text, token, context);

                  setState(() {
                    isLoading = false;
                  });
                } else {
                  messageAlert(context,
                      "Por favor verfica si tienes datos o conexión wifi");
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(88, 44),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorPrimary, colorSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 180.0,
                    minHeight: 50.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "INICIAR SESIÓN",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: colorPrimary,
              ),
            ),
    );
  }

  Widget _usernameWidget() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controllerUsername,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            labelText: 'Usuario o Nit',
            labelStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(
              Ionicons.person_outline,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorPrimary),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordWidget() {
    return Column(
      children: [
        TextFormField(
          controller: _controllerPassword,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(
              Ionicons.lock_open_outline,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorPrimary),
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: colorPrimary,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _logo() {
    return Image(
      height: 150,
      width: 280,
      image: AssetImage('assets/images/cadegran.png'),
    );
  }

  void messageAlert(BuildContext context, String message) {
    showOkAlertDialog(
      context: context,
      title: "Notificación",
      message: message,
    );
  }
}
