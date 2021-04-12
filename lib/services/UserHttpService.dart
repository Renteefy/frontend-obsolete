import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserHttpService {
  final String url = env['SERVER_URL'];
  // final String url = env['SERVER_URLx'];
  final store = new FlutterSecureStorage();

  Future<bool> checkInvite(String username) async {
    http.Response response = await http.post(
      Uri.https(url, "users/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'username': username}),
    );
    if (response.statusCode == 200) {
      String username = json.decode(response.body)["username"];
      print(username + " logged in");
      await store.write(key: 'jwt', value: json.decode(response.body)["token"]);
      await store.write(key: 'username', value: username);
      return true;
    } else {
      return false;
    }
  }
}
