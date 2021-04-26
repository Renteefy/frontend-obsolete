import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/shared/constants.dart';
import 'package:frontend/pages/EditProfile.dart';
import 'package:frontend/pages/InviteUser.dart';
import 'package:frontend/pages/BugReportPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/pages/LandingPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String url = "https://" + env['SERVER_URL'];
final store = new FlutterSecureStorage();

class UserInfoCard extends StatelessWidget {
  final userDetails;
  UserInfoCard({Key key, this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (userDetails == null)
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (userDetails.firstName == null &&
                            userDetails.lastName == null)
                        ? Text(userDetails.username,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: kPrimaryColor))
                        : Text(
                            userDetails.firstName + " " + userDetails.lastName,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: kPrimaryColor)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(userDetails.email,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, color: kAccentColor3)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      firstName: userDetails.firstName,
                                      lastName: userDetails.lastName,
                                      url: userDetails.picture,
                                      username: userDetails.username));
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(Icons.email_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => InviteUser());
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(Icons.bug_report_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => BugReportPage());
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            var route = MaterialPageRoute(
                                builder: (context) => LandingPage());
                            VoidCallback continueCallBack = () async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userDetails.email)
                                  .set({"token": null});
                              store.write(key: 'username', value: null);
                              Navigator.of(context).pushReplacement(route);
                              // code on Okay comes here
                            };
                            BlurryDialog alert = BlurryDialog(
                                "Logout",
                                "Are you sure you want to logout?",
                                continueCallBack,
                                true);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: (userDetails.picture.startsWith("/static"))
                    ? NetworkImage(url + userDetails.picture)
                    : NetworkImage(userDetails.picture),
              ),
            ],
          );
  }
}
