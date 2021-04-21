import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//env
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:frontend/app.dart';

// to avoid the handshake error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DotEnv.load(fileName: ".env");
  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
