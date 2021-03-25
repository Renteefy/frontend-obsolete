import 'package:flutter/material.dart';

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
        title: "Renteefy",
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor),
        home: LandingPage());
  }
}
