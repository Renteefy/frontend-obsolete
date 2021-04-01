import 'package:flutter/material.dart';
import 'package:frontend/pageController/HomePageController.dart';
import 'package:frontend/pages/AssetsCatalogPage.dart';
import 'package:frontend/pages/NotificationPage.dart';

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
        "/home": (context) => HomePageController(),
        "/assetCatalog": (context) => AssetCatalogPage(),
        "/notification": (context) => NotificationPage(),
      },
      title: "Renteefy",
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor),
    );
  }
}
