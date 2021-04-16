import 'package:flutter/foundation.dart';

class ItemListing {
  final String itemID;
  final String title;
  final String price;
  final String interval;
  final String url;
  final String date;
  final String category;

  ItemListing({
    @required this.itemID,
    @required this.title,
    @required this.price,
    @required this.interval,
    @required this.url,
    @required this.date,
    this.category,
  });

  factory ItemListing.fromJson(Map<String, dynamic> json) {
    return ItemListing(
        itemID: json['id'] as String,
        title: json['title'] as String,
        price: json['price'] as String,
        interval: json['interval'] as String,
        url: json['url'] as String,
        category: json['category'] as String,
        date: json['date'] as String);
  }
}

class SingleItem {
  final String itemID;
  final String title;
  final String price;
  final String interval;
  final String url;
  final String description;
  final String owner;
  final String category;
  final String renter; // person who is presently renting the product
  final List<String> waitingList;
  SingleItem({
    @required this.itemID,
    @required this.title,
    @required this.price,
    @required this.interval,
    @required this.url,
    @required this.description,
    this.category,
    this.owner,
    this.renter,
    this.waitingList,
  });

  factory SingleItem.fromJson(Map<String, dynamic> json) {
    return SingleItem(
      itemID: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      interval: json['interval'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      owner: json['owner'] as String,
      renter: json['renter'] as String,
      category: json['category'] as String,
    );
  }
}
