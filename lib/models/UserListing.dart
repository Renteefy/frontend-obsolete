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
        username: json['username'] as String,
        email: json['email'] as String,
        picture: (json['picture'] != null && json["picture"] != "/static/null")
            ? json['picture'] as String
            : (json["firstName"] != null && json["lastName"] != null)
                ? "https://ui-avatars.com/api/?name=${json["firstName"]}+${json["lastName"]}"
                : "https://via.placeholder.com/230",
        firstName: json["firstName"],
        lastName: json["lastName"],
        date: json['date'] as String);
  }
}

class InviteModel {
  final String inviteID;
  final String inviteeEmail;

  InviteModel({@required this.inviteID, @required this.inviteeEmail});

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      inviteID: json['_id'] as String,
      inviteeEmail: json['inviteeEmail'] as String,
    );
  }
}
