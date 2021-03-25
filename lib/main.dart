import 'package:flutter/material.dart';
import './landing.dart';

void main() => runApp(
    MaterialApp(theme: ThemeData(brightness: Brightness.dark), home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // const colour = const Color(0xfEF476f);
    return Scaffold(
      backgroundColor: Colors.black,
      body: LandingPage(),
    );
  }
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
