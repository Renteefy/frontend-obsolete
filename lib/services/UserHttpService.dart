import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/UserListing.dart';

class UserHttpService {
  final String url = env['SERVER_URL'];
  // final String url = env['SERVER_URLx'];
  final store = new FlutterSecureStorage();

  Future<bool> checkInvite(String email) async {
    http.Response response = await http.post(
      Uri.https(url, "users/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email}),
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      String username = jsonData["username"];
      print(username + " logged in");
      await store.write(key: 'jwt', value: jsonData["token"]);
      await store.write(key: 'username', value: username);
      await store.write(key: 'picture', value: jsonData["picture"]);
      // get notification from database
      await store.write(
          key: 'notificationCount', value: jsonData["notificationCount"]);
      return true;
    } else {
      return false;
    }
  }

  Future<UserListing> getUserDetails() async {
    String value = await store.read(key: "jwt");
    var data = await http.get(Uri.https(url, "users/user"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve userinfo.";
    }
    var jsonData = json.decode(data.body);
    UserListing user = UserListing.fromJson(jsonData);
    return user;
  }

  Future<int> patchUserDetails(
      String firstName, String lastName, String username, picture) async {
    String value = await store.read(key: "jwt");
    var request = http.MultipartRequest("PATCH", Uri.https(url, "users/user/"));
    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["username"] = username;

    if (picture != null) {
      request.files
          .add(await http.MultipartFile.fromPath('UserImage', picture));
    }
    request.headers.addAll(
        {'Content-Type': 'multipart/form-data', 'Authorization': value});

    var response = await request.send();
    var respStr = await http.Response.fromStream(response);
    return (respStr.statusCode);
  }

  Future<String> sendInvite(String email) async {
    String value = await store.read(key: "jwt");
    http.Response response = await http.post(Uri.https(url, "users/sendInvite"),
        headers: {"Content-Type": "application/json", 'Authorization': value},
        body: json.encode({"email": email}));
    if (response.statusCode == 200) {
      return json.decode(response.body)["id"];
    } else if (response.statusCode == 409) {
      return "Email already exists";
    } else {
      return "0";
    }
  }

  Future<List<InviteModel>> getInvites() async {
    String value = await store.read(key: "jwt");
    http.Response response = await http.get(
      Uri.https(url, "users/getInvites"),
      headers: {"Content-Type": "application/json", 'Authorization': value},
    );
    var jsonData = json.decode(response.body);

    List<InviteModel> invites = [];
    for (var inv in jsonData["inviteList"]) {
      final tmp = InviteModel.fromJson(inv);
      invites.add(tmp);
    }
    return invites;
  }

  Future<int> deleteInvite(String email, String inviteID) async {
    String value = await store.read(key: "jwt");
    http.Response response = await http.delete(
        Uri.https(url, "users/deleteInvite"),
        headers: {"Content-Type": "application/json", 'Authorization': value},
        body: json.encode({"email": email, "inviteID": inviteID}));
    return response.statusCode;
  }
}
