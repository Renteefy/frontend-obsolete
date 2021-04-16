import 'package:flutter/material.dart';
import 'package:frontend/pageController/HomePageController.dart';
import 'package:frontend/pages/CatalogPage.dart';
import 'package:frontend/pages/ChatListingPage.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/EditPage.dart';
import 'package:frontend/pages/NotificationPage.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/pages/EditProfile.dart';

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
        "/assetCatalog": (context) => CatalogPage(),
        "/notification": (context) => NotificationPage(),
        "/productDetail": (context) => ProductDetails(),
        "/chatListing": (context) => ChatListingPage(),
        "/editListing": (context) => EditListingPage(),
        "/editProfile": (context) => EditProfile(),
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
