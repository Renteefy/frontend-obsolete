import 'package:flutter/foundation.dart';

class NotificationListing {
  final String assetID;
  final String title;
  final String price;
  final String interval;
  final String url;

  NotificationListing({
    @required this.assetID,
    @required this.title,
    @required this.price,
    @required this.interval,
    @required this.url,
  });

  factory NotificationListing.fromJson(Map<String, dynamic> json) {
    return NotificationListing(
      assetID: json['assetID'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      interval: json['interval'] as String,
      url: json['url'] as String,
    );
  }
}
