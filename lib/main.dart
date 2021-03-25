import 'package:flutter/material.dart';

//env
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:frontend/app.dart';

Future main() async {
  await DotEnv.load(fileName: ".env");
  runApp(App());
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
