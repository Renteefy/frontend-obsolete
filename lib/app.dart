import 'package:flutter/material.dart';
import 'package:frontend/pages/HomePage.dart';

// constants
import './shared/constants.dart';

// pages
import './pages/LandingPage.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => LandingPage(),
        "/home": (context) => HomePage(),
      },
      title: "Renteefy",
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor),
    );
  }
}
