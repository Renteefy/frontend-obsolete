import 'package:flutter/foundation.dart';

class UserListing {
  final String userID;
  final String username;
  final String email;
  final String picture;
  final String firstName;
  final String lastName;
  final String date;

  UserListing({
    @required this.userID,
    @required this.username,
    @required this.email,
    @required this.picture,
    @required this.firstName,
    @required this.lastName,
    @required this.date,
  });

  factory UserListing.fromJson(Map<String, dynamic> json) {
    return UserListing(
        userID: json['_id'] as String,
        username: (json['username'] != null)
            ? json['username'] as String
            : "placeHolder",
        email: (json['email'] != null)
            ? json['email'] as String
            : "place@holder.com",
        picture: (json['picture'] != null)
            ? json['picture'] as String
            : "https://via.placeholder.com/230",
        firstName:
            (json['firstName'] != null) ? json['firstName'] as String : "Place",
        lastName:
            (json['lastName'] != null) ? json['lastName'] as String : "Holder",
        date: json['date'] as String);
  }
}
