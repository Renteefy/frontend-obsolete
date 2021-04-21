import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/GlobalState.dart';
import 'package:frontend/pageController/HomePageController.dart';
import 'package:frontend/pages/CatalogPage.dart';
import 'package:frontend/pages/ChatListingPage.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/EditPage.dart';
import 'package:frontend/pages/NotificationPage.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/pages/EditProfile.dart';
import 'package:provider/provider.dart';

// constants
import './shared/constants.dart';

// pages
import './pages/LandingPage.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String username = "";
  final store = FlutterSecureStorage();
  void resolveUsername() async {
    String user = await store.read(key: "username");
    setState(() {
      username = user;
    });
  }

  @override
  void initState() {
    resolveUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalState>(
      create: (context) => GlobalState(),
      child: MaterialApp(
        routes: {
          "/assetCatalog": (context) => CatalogPage(),
          "/notification": (context) => NotificationPage(),
          "/productDetail": (context) => ProductDetails(),
          "/chatListing": (context) => ChatListingPage(),
          "/editListing": (context) => EditListingPage(),
          "/editProfile": (context) => EditProfile(),
          "/chat": (context) => ChatView(),
          '/home': (context) => HomePageController()
        },
        home: (username == null || username.isEmpty)
            ? LandingPage()
            : HomePageController(),
        title: "Renteefy",
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor),
      ),
    );
  }
}
