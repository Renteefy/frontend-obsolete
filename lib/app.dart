import 'package:flutter/material.dart';
import 'package:frontend/pageController/HomePageController.dart';
import 'package:frontend/pages/AssetsCatalogPage.dart';
import 'package:frontend/pages/ChatListingPage.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/NotificationPage.dart';
import 'package:frontend/pages/ProductDetails.dart';

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
        "/productDetail": (context) => ProductDetails(),
        "/chatListing": (context) => ChatListingPage(),
        "/chat": (context) => ChatView(),
      },
      title: "Renteefy",
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor),
    );
  }
}
