import 'package:flutter/foundation.dart';

class AssetListing {
  final String assetID;
  final String title;
  final String price;
  final String interval;
  final String url;

  AssetListing({
    @required this.assetID,
    @required this.title,
    @required this.price,
    @required this.interval,
    this.url = "https://via.placeholder.com/150",
  });

  factory AssetListing.fromJson(Map<String, dynamic> json) {
    return AssetListing(
      assetID: json['assetID'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      interval: json['interval'] as String,
      url: json['url'] as String,
    );
  }
}
