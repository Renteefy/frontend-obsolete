import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/NotificationListing.dart';

class NotificationHttpService {
  final String url = env['SERVER_URL'];
  final store = new FlutterSecureStorage();

  Future<List<NotificationListing>> getUserNotifications() async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "notifications/user/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Notifications.";
    }

    List<NotificationListing> notifications = [];

    for (var notif in jsonData) {
      final tmp = NotificationListing.fromJson(notif);
      notifications.add(tmp);
    }

    return notifications;
  }

  Future<String> postNotification(String title, String status, String owner,
      String itemID, String itemType) async {
    String value = await store.read(key: "jwt");
    http.Response response = await http.post(
      Uri.https(url, "notifications"),
      headers: {"Content-Type": "application/json", 'Authorization': value},
      body: json.encode({
        'title': title,
        'status': status,
        'owner': owner,
        'itemID': itemID,
        'itemType': itemType
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)["id"];
    } else {
      return "0";
    }
  }

  void deleteNotificaiton(String notificationID) async {
    String value = await store.read(key: "jwt");
    await http.delete(
        Uri.https(url, "notifications/notification/$notificationID"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    print("$notificationID deleted");
  }

  Future<int> patchNotification(String propName, String value, String notifID,
      String renteeUsername) async {
    String token = await store.read(key: "jwt");
    var changes =
        '{"changes": [{"propName": "$propName", "value": "$value"}], "renteeUsername":"$renteeUsername"}';

    http.Response response = await http.patch(
        Uri.https(url, "notifications/notification/$notifID"),
        body: changes,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return (response.statusCode);
  }
}
