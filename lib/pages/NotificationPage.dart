import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/components/NotificationCard.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/NotificationsHttpService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final store = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  List<NotificationListing> notificationList = [];
  String username;

  void fetchNotifications() async {
    String value = await store.read(key: "username");
    setState(() {
      username = value;
    });
    List<NotificationListing> notifications =
        await NotificationHttpService().getUserNotifications();
    setState(() {
      notificationList = notifications;
    });
    // print(notificationList);
  }

  // the list view builder will loop through this notification listing array.
  // if (owner of current item == username from flutter secure storage )
  //  render Owner card (with accept and reject options)
  // else render Rentee card (without any options only status and chat with owner button)
  @override
  Widget build(BuildContext context) {
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
                    return NotificationCard(
                      notifi: notificationList[index],
                      isRentee: (notificationList[index].owner ==
                              username) // replace yaj with the logged in username
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
