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
    this.owner,
    this.renter,
    this.waitingList,
  });

  factory SingleAsset.fromJson(Map<String, dynamic> json) {
    return SingleAsset(
      assetID: json["assetResponse"]['assetID'] as String,
      title: json["assetResponse"]['title'] as String,
      price: json["assetResponse"]['price'] as String,
      interval: json["assetResponse"]['interval'] as String,
      url: json["assetResponse"]['url'] as String,
      description: json["assetResponse"]['description'] as String,
      owner: json["assetResponse"]['owner'] as String,
      renter: json["assetResponse"]['renter'] as String,
    );
  }
}
