// To parse this JSON data, do
//
//     final chatListing = chatListingFromJson(jsonString);

import 'dart:convert';

ChatListing chatListingFromJson(String str) =>
    ChatListing.fromJson(json.decode(str));

String chatListingToJson(ChatListing data) => json.encode(data.toJson());

class ChatListing {
  ChatListing({
    this.user1,
    this.user2,
    this.lastMessage,
    this.chatId,
  });

  String user1;
  String user2;
  String lastMessage;
  String chatId;

  factory ChatListing.fromJson(Map<String, dynamic> json) => ChatListing(
        user1: json["user1"],
        user2: json["user2"],
        lastMessage: json["lastMessage"],
        chatId: json["chatID"],
      );

  Map<String, dynamic> toJson() => {
        "user1": user1,
        "user2": user2,
        "lastMessage": lastMessage,
        "chatID": chatId,
      };
}
