import 'package:flutter/widgets.dart';

class GlobalState with ChangeNotifier {
  String someValue = 'Hello';
  int notificationCount = 7;

  void incrementCounter() {
    notificationCount++;
    notifyListeners();
  }

  void doSomething() {
    someValue = 'Goodbye';
    print(someValue);
  }
}
