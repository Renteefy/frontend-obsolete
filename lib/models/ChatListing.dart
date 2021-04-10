import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class ChatListing {
  final String chatID;
  final String user1;
  final String user2;

  ChatListing({
    @required this.chatID,
    @required this.user1,
    @required this.user2,
  });

  factory ChatListing.fromJson(Map<String, dynamic> json) {
    return ChatListing(
      chatID: json['chatID'] as String,
      user1: json['user1'] as String,
      user2: json['user2'] as String,
    );
  }
}
