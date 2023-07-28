import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

import '/classes/paladinsapi.dart';

import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String sessionllave = await PaladinsApi().setupsession();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Locks the device in portrait mode
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(WillPopScope(
    onWillPop: () async {
      return true;
    },
    child: MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(40, 155, 184, 72),
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(24, 90, 107, 42)),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
      routes: {
        '/': (context) => UpgradeAlert(
              child: Home(
                sessionid: sessionllave,
              ),
            ),
      },
    ),
  ));
}
