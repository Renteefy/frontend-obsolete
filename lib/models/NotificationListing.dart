import 'package:flutter/foundation.dart';

class NotificationListing {
  final String notificationID;
  final String title;
  final String status;
  final String rentee;
  final String url;

  NotificationListing({
    @required this.notificationID,
    @required this.title,
    @required this.status,
    @required this.rentee,
    @required this.url,
  });

  factory NotificationListing.fromJson(Map<String, dynamic> json) {
    return NotificationListing(
      notificationID: json['notificationID'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      rentee: json['rentee'] as String,
      url: json['url'] as String,
    );
  }
}
