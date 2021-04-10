import 'dart:convert';

ChatListing chatListingFromJson(String str) =>
    ChatListing.fromJson(json.decode(str));

String chatListingToJson(ChatListing data) => json.encode(data.toJson());

class ChatListing {
  ChatListing({
    this.chatID,
    this.user1,
    this.user2,
  });

  String chatID;
  User user1;
  User user2;

  factory ChatListing.fromJson(Map<String, dynamic> json) => ChatListing(
        chatID: json["chatID"],
        user1: User.fromJson(json["user1"]),
        user2: User.fromJson(json["user2"]),
      );

  Map<String, dynamic> toJson() => {
        "chatID": chatID,
        "user1": user1.toJson(),
        "user2": user2.toJson(),
      };
}

class User {
  User({
    this.username,
    this.lastMessage,
  });

  String username;
  String lastMessage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        lastMessage: json["lastMessage"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "lastMessage": lastMessage,
      };
}
