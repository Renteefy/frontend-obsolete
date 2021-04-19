import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("notification");
    IOSInitializationSettings iOSinitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iOSinitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future sendNotification(String title, String body) async {
    var android = AndroidNotificationDetails("id", "channel", "description");
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: body);
  }
}
