import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/components/NotificationCard.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

// NotificationPage:
// json required :
// res :[{
//   status: String, //request raised, accepted, rejected
//   owner: String,
//   title: String,
//   url: String // url of the image
// }]

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> res = [
    {
      "url": "https://via.placeholder.com/150",
      "title":
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,",
      "rentee": "Ayush",
      "owner": "yaj",
      "status": "Request Raised",
    },
    {
      "url": "https://via.placeholder.com/150",
      "title":
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,",
      "rentee": "Ayush",
      "owner": "yaj1",
      "status": "Request Raised",
    }
  ];
  // res comes in gets converted in to Notification listing object array.
  // the list view builder will loop through this notification listing array.
  // if (owner of current item == username from flutter secure storage )
  //  render Owner card (with accept and reject options)
  // else render Rentee card (without any options only status and chat with owner button)
  @override
  Widget build(BuildContext context) {
    List<NotificationListing> notificationList =
        res.map((dynamic item) => NotificationListing.fromJson(item)).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Latest ",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    )),
                Text("Notifications",
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: kPrimaryColor)),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    print(notificationList[index].owner);
                    return NotificationCard(
                      notifi: notificationList[index],
                      isRentee: (notificationList[index].owner ==
                              "yaj") // replace yaj with the logged in username
                          ? false
                          : true,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
