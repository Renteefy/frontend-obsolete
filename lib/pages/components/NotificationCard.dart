import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/services/ChatHttpService.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/NotificationsHttpService.dart';
import 'package:web_socket_channel/io.dart';

class NotificationCard extends StatefulWidget {
  final NotificationListing notifi;
  final bool isRentee;

  NotificationCard({this.notifi, @required this.isRentee});

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.isRentee == true) {
      return GestureDetector(
        onTap: () {
          var route = MaterialPageRoute(
              builder: (context) => ProductDetails(
                    itemID: widget.notifi.itemID,
                    item: widget.notifi.itemType,
                  ));
          Navigator.of(context).push(route);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.notifi.title,
                              style: GoogleFonts.inter(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline_outlined,
                                  size: 30,
                                  color: Color(0xffd9d7d7),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Rentee: " + widget.notifi.rentee,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xffd9d7d7)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                (widget.notifi.status == "Request Raised")
                                    ? Icon(
                                        Icons.warning_rounded,
                                        size: 30,
                                        color: Color(0xffd9d7d7),
                                      )
                                    : (widget.notifi.status == "Accepted")
                                        ? Icon(
                                            Icons.done_all_outlined,
                                            size: 30,
                                            color: Color(0xffd9d7d7),
                                          )
                                        : Icon(
                                            Icons.cancel,
                                            size: 30,
                                            color: Color(0xffd9d7d7),
                                          ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Status: " + widget.notifi.status,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xffd9d7d7)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          primary: Colors.transparent,
                        ),
                        onPressed: () async {
                          var chatList = await ChatHttpService().getChatRoom(
                              widget.notifi.rentee, widget.notifi.owner);

                          var route = MaterialPageRoute(
                              builder: (context) => ChatView(
                                    channel: IOWebSocketChannel.connect(
                                        ("wss://chat.renteefy.ga/ws?username=" +
                                            widget.notifi.rentee)),
                                    username: widget.notifi.rentee,
                                    chatID: chatList.chatID,
                                    chatee: widget.notifi.owner,
                                  ));
                          Navigator.of(context).push(route);
                        },
                        icon: Icon(Icons.messenger_outline_outlined),
                        label: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Chat with " + widget.notifi.owner,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          var route = MaterialPageRoute(
              builder: (context) => ProductDetails(
                    itemID: widget.notifi.itemID,
                    item: widget.notifi.itemType,
                  ));
          Navigator.of(context).push(route);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.notifi.title,
                              style: GoogleFonts.inter(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline_outlined,
                                  size: 30,
                                  color: Color(0xffd9d7d7),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Rentee: " + widget.notifi.rentee,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xffd9d7d7)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                (widget.notifi.status == "Request Raised")
                                    ? Icon(
                                        Icons.warning_rounded,
                                        size: 30,
                                        color: Color(0xffd9d7d7),
                                      )
                                    : (widget.notifi.status == "Accepted")
                                        ? Icon(
                                            Icons.done_all_outlined,
                                            size: 30,
                                            color: Color(0xffd9d7d7),
                                          )
                                        : Icon(
                                            Icons.cancel,
                                            size: 30,
                                            color: Color(0xffd9d7d7),
                                          ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Status: " + widget.notifi.status,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xffd9d7d7)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: (widget.notifi.status != "Accepted")
                              ? Icon(Icons.check)
                              : Icon(Icons.refresh),
                          color: kAccentColor1,
                          onPressed: (widget.notifi.status != "Accepted")
                              ? () async {
                                  ItemsHttpService().setRenter(
                                      widget.notifi.itemType,
                                      widget.notifi.itemID,
                                      widget.notifi.rentee);
                                  int resStatus =
                                      await NotificationHttpService()
                                          .patchNotification(
                                              "status",
                                              "Accepted",
                                              widget.notifi.notificationID,
                                              widget.notifi.rentee);
                                  if (resStatus == 200) {
                                    setState(() {
                                      widget.notifi.status = "Accepted";
                                    });
                                  }
                                }
                              : () async {
                                  ItemsHttpService().setRenter(
                                      widget.notifi.itemType,
                                      widget.notifi.itemID,
                                      null);
                                  int resStatus =
                                      await NotificationHttpService()
                                          .patchNotification(
                                              "status",
                                              "Request Raised",
                                              widget.notifi.notificationID,
                                              widget.notifi.rentee);

                                  if (resStatus == 200) {
                                    setState(() {
                                      widget.notifi.status = "Request Raised";
                                    });
                                  }
                                }),
                      IconButton(
                          icon: (widget.notifi.status != "Denied")
                              ? Icon(Icons.close)
                              : Icon(Icons.refresh),
                          color: kPrimaryColor,
                          onPressed: (widget.notifi.status != "Denied")
                              ? () async {
                                  int resStatus =
                                      await NotificationHttpService()
                                          .patchNotification(
                                              "status",
                                              "Denied",
                                              widget.notifi.notificationID,
                                              widget.notifi.rentee);
                                  ItemsHttpService().setRenter(
                                      widget.notifi.itemType,
                                      widget.notifi.itemID,
                                      null);
                                  if (resStatus == 200) {
                                    setState(() {
                                      widget.notifi.status = "Denied";
                                    });
                                  }
                                }
                              : () async {
                                  int resStatus =
                                      await NotificationHttpService()
                                          .patchNotification(
                                              "status",
                                              "Request Raised",
                                              widget.notifi.notificationID,
                                              widget.notifi.rentee);
                                  if (resStatus == 200) {
                                    setState(() {
                                      widget.notifi.status = "Request Raised";
                                    });
                                  }
                                }),
                      IconButton(
                          icon: Icon(Icons.messenger_outline),
                          onPressed: () async {
                            var chatList = await ChatHttpService().getChatRoom(
                                widget.notifi.rentee, widget.notifi.owner);

                            var route = MaterialPageRoute(
                                builder: (context) => ChatView(
                                      channel: IOWebSocketChannel.connect(
                                          ("wss://chat.renteefy.ga/ws?username=" +
                                              widget.notifi.rentee)),
                                      username: widget.notifi.rentee,
                                      chatID: chatList.chatID,
                                      chatee: widget.notifi.owner,
                                    ));
                            Navigator.of(context).push(route);
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
