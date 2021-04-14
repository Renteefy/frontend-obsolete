import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/AddPage.dart';
import 'package:frontend/pages/DashboardPage.dart';
import 'package:frontend/pages/HomePage.dart';
import 'package:frontend/shared/TopBar.dart';
import 'package:frontend/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePageController extends StatefulWidget {
  @override
  _HomePageControllerState createState() => _HomePageControllerState();
}

final store = new FlutterSecureStorage();
final String url = env['SERVER_URL'];
String picture;

class _HomePageControllerState extends State<HomePageController> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getPicture();
  }

  void getPicture() async {
    String tmp = await store.read(key: "picture");
    setState(() {
      picture = tmp;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddPage(),
    DashboardPage(),
  ];
  static List<List<String>> title = [
    ["Home", ""],
    ["Add", "Listing"],
    ["Dashboard", ""],
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title[_selectedIndex]),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: (picture == null)
                ? CircularProgressIndicator()
                : BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add),
                        label: 'Add Listing',
                      ),
                      BottomNavigationBarItem(
                        icon: CircleAvatar(
                          radius: 13,
                          backgroundImage: (picture != "/static/null")
                              ? NetworkImage("https://" + url + picture)
                              : NetworkImage(
                                  "https://ui-avatars.com/api/?name=Place+Holder"),
                        ),
                        label: 'Dashboard',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: kAccentColor1,
                    onTap: _onItemTapped,
                  ),
          ),
        ),
      ),
    );
  }
}
