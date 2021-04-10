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
    @required this.url,
  });

  factory AssetListing.fromJson(Map<String, dynamic> json) {
    return AssetListing(
        assetID: json['assetID'] as String,
        title: json['title'] as String,
        price: json['price'] as String,
        interval: json['interval'] as String,
        url: json['url'] as String);
  }
}

class SingleAsset {
  final String assetID;
  final String title;
  final String price;
  final String interval;
  final String url;
  final String description;
  final String owner;
  final String renter; // person who is presently renting the product
  final List<String> waitingList;
  SingleAsset({
    @required this.assetID,
    @required this.title,
    @required this.price,
    @required this.interval,
    @required this.url,
    @required this.description,
    @required this.owner,
    @required this.renter,
    this.waitingList,
  });

  factory SingleAsset.fromJson(Map<String, dynamic> json) {
    return SingleAsset(
      assetID: json['assetID'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      interval: json['interval'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      owner: json['owner'] as String,
      renter: json['owner'] as String,
    );
  }
}
