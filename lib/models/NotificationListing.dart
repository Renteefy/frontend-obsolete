import 'package:flutter/foundation.dart';

class NotificationListing {
  final String notificationID;
  final String itemID;
  final String title;
  String status;
  final String rentee;
  final String owner;
  final String itemType;

  NotificationListing({
    @required this.notificationID,
    @required this.itemID,
    @required this.title,
    @required this.status,
    @required this.rentee,
    @required this.owner,
    @required this.itemType,
  });

  factory NotificationListing.fromJson(Map<String, dynamic> json) {
    return NotificationListing(
      notificationID: json['_id'] as String,
      itemID: json['itemID'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      rentee: json['rentee'] as String,
      owner: json['owner'] as String,
      itemType: json['itemType'] as String,
    );
  }
}
