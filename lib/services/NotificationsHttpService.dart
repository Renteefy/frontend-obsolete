import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/NotificationListing.dart';

class NotificationHttpService {
  final String url = env['SERVER_URL'];
  // final String url = env['SERVER_URLx'];
  final store = new FlutterSecureStorage();

  Future<List<NotificationListing>> getUserNotifications() async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "notifications/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Notifications.";
    }

    List<NotificationListing> notifications = [];

    for (var notif in jsonData["notifications"]) {
      final tmp = NotificationListing(
          notificationID: notif["notificationID"],
          title: notif["title"],
          status: notif["status"],
          rentee: notif["rentee"],
          owner: notif["owner"]);

      notifications.add(tmp);
    }

    return notifications;
  }

  Future<String> postNotification(
      String title, String status, String owner) async {
    String value = await store.read(key: "jwt");
    http.Response response = await http.post(
      Uri.https(url, "notifications"),
      headers: {"Content-Type": "application/json", 'Authorization': value},
      body: json.encode({'title': title, 'status': status, 'owner': owner}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)["id"];
    } else {
      return "0";
    }
  }

  Future<String> isAlreadyRented(String title) async {
    String value = await store.read(key: "jwt");
    var data = await http.get(
        Uri.https(url, "notifications/user/alreadySent/$title"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    if (data.statusCode == 200) {
      return json.decode(data.body)[0]["_id"];
    } else {
      return "0";
    }
  }

  void deleteNotificaiton(String notificationID) async {
    String value = await store.read(key: "jwt");
    var res = await http.delete(
        Uri.https(url, "notifications/notification/$notificationID"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    print(res.statusCode);
    print(res.body);
  }
}
