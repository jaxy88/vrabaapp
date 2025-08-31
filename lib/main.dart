import 'dart:io';

import 'package:app/screens/welcome/welcome_screen.dart';
import 'package:app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:app/modules/login/view/login_view.dart';
import 'package:app/utils/check_internet_connection.dart';
import 'package:app/utils/constants.dart';
import 'package:get/get.dart';

final internetChecker = CheckInternetConnection();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var currentRoute = "login";
  bool isLogged = false;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Raleway',
          appBarTheme: AppBarTheme(
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
          ),
        ),
        darkTheme: Themes.dark,
        title: 'App',
        routes: {"login": (BuildContext context) => LoginView()},
        home: WelcomeScreen()
        //LoginView(),
        // home: isLogged ? _getRouteWidget(currentRoute) : LoginView(),
        );
  }
}
