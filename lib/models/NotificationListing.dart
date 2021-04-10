import 'package:flutter/foundation.dart';

class NotificationListing {
  final String notificationID;
  final String assetID;
  final String title;
  String status;
  final String rentee;
  final String owner;

  NotificationListing({
    @required this.notificationID,
    @required this.assetID,
    @required this.title,
    @required this.status,
    @required this.rentee,
    @required this.owner,
  });

  factory NotificationListing.fromJson(Map<String, dynamic> json) {
    return NotificationListing(
      notificationID: json['_id'] as String,
      assetID: json['assetID'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      rentee: json['rentee'] as String,
      owner: json['owner'] as String,
    );
  }
}
