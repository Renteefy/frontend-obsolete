import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/AddPage.dart';
import 'package:frontend/pages/DashboardPage.dart';
import 'package:frontend/pages/HomePage.dart';
import 'package:frontend/shared/constants.dart';

class HomePageController extends StatefulWidget {
  @override
  _HomePageControllerState createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddPage(),
    DashboardPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.notifications_none_rounded),
                iconSize: 30,
                onPressed: () {}),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
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
                  backgroundImage:
                      NetworkImage("https://ui-avatars.com/api/?name=John+Doe"),
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
    );
  }
}
