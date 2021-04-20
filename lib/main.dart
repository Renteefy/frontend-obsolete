import 'dart:io';

import 'package:flutter/material.dart';

//env
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:frontend/app.dart';
import 'package:frontend/services/LocalNotifications.dart';
import 'package:workmanager/workmanager.dart';

// to avoid the handshake error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// to make a background task with Workmanager
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    LocalNotificationService().initialize();
    LocalNotificationService().sendNotification("title", " body");
    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask(
    "testTask",
    "testTask",
    inputData: {"data": "someData"},
  );
  await DotEnv.load(fileName: ".env");
  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
