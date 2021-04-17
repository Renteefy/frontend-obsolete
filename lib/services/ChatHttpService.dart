import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/ChatObj.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/ChatRoom.dart';

class ChatHttpService {
  final String url = env['CHAT_SERVER_URL'];
  // final String url = env['SERVER_URLx'];
  final store = new FlutterSecureStorage();
  Future<ChatRoom> getChatRoom(String user1, String user2) async {
    String value = await store.read(key: "jwt");
    var data = await http.post(Uri.https(url, "chatRoom"),
        headers: {'Content-Type': 'application/json', 'Authorization': value},
        body: json.encode({'user1': user1, "user2": user2}));
    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve chatroom details.";
    }
    var jsonData = json.decode(data.body);
    ChatRoom chatroom = ChatRoom.fromJson(jsonData);
    return chatroom;
  }

  Future<List<ChatRoom>> getChatRoomForUser(String username) async {
    //String value = await store.read(key: "jwt");
    print(username);
    var data = await http.get(
      Uri.https(
        url,
        "userchatRoom/" + username,
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (data.statusCode != 200) {
      print(data.reasonPhrase);
      print("Auth Failed, please login");
      return null;
    } else {
      var jsonData = json.decode(data.body);

      List<ChatRoom> chatrooms = [];
      for (var item in jsonData) {
        chatrooms.add(ChatRoom.fromJson(item));
      }
      return chatrooms;
    }
  }

  Future<ChatObj> getAllChats(String chatID) async {
    var data = await http.post(
      Uri.https(
        url,
        "chats/",
      ),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"chatID": chatID}),
    );
    var chatsbaby = ChatObj.fromJson(json.decode(data.body));
    return chatsbaby;
  }
}
