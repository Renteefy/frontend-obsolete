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
import 'package:frontend/services/LocalNotification.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

// constants
import './shared/constants.dart';

// pages
import './pages/LandingPage.dart';

void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void doInitStuff() async {
  final store = FlutterSecureStorage();
  String username = await store.read(key: "username");
  print(username);
  if (username.isNotEmpty) {
    LocalNotificationService().initialize();
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    Workmanager().registerOneOffTask("1", "simpleTask");
  }
}

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
    doInitStuff();
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
        },
        home: (username.isEmpty) ? LandingPage() : HomePageController(),
        title: "Renteefy",
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor),
      ),
    );
  }
}
