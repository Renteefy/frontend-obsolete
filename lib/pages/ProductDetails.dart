// these are the changes
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/EditPage.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/services/NotificationsHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductDetails extends StatefulWidget {
  final String itemID;
  final String item;
  const ProductDetails({Key key, this.itemID, this.item}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final itemService = ItemsHttpService();
  SingleItem product;
  NotificationListing notifi;
  bool loading = true;
  String rentedStatus;
  String notifiID;
  final String url = "https://" + env['SERVER_URL'];

  @override
  void initState() {
    super.initState();

    () async {
      List itemNotifi =
          await itemService.getSingleItem(widget.itemID, widget.item);
      if (itemNotifi[1] != "") {
        setState(() {
          product = itemNotifi[0];
          notifi = itemNotifi[1];
          loading = false;
          rentedStatus = notifi.status;
          notifiID = notifi.notificationID;
        });
      } else {
        setState(() {
          product = itemNotifi[0];
          loading = false;
        });
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Product ",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w900)),
              Text("Details",
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900)),
            ],
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_none_rounded),
                iconSize: 30,
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                })
          ],
        ),
        body: (loading == true)
            ? Center(child: CircularProgressIndicator())
            : Details(
                url: url,
                product: product,
                notifi: notifi,
                rentedStatus: rentedStatus,
                notifiID: notifiID,
                item: widget.item,
              ));
  }
}

class Details extends StatefulWidget {
  Details({
    Key key,
    @required this.url,
    @required this.product,
    @required this.notifi,
    @required this.rentedStatus,
    @required this.notifiID,
    @required this.item,
  }) : super(key: key);

  final String url;
  String rentedStatus;
  String notifiID;
  final SingleItem product;
  final String item;
  final NotificationListing notifi;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final store = new FlutterSecureStorage();
  final notifiService = NotificationHttpService();

  String username;
  @override
  void initState() {
    super.initState();
    resolveUsername();
  }

  void resolveUsername() async {
    var tmp = await store.read(key: "username");
    setState(() {
      username = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child:
                                Image.network(widget.url + widget.product.url)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.product.title,
                        style: GoogleFonts.inter(
                            fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.description,
                        style: GoogleFonts.inter(
                            color: Color(0xffBDBDBD),
                            fontSize: 14,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rs. ",
                            style: GoogleFonts.inter(
                                color: Color(0xffBDBDBD),
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            widget.product.price + " ",
                            style: GoogleFonts.inter(
                                color: kPrimaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            widget.product.interval,
                            style: GoogleFonts.inter(
                                color: kPrimaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.network(
                              "https://via.placeholder.com/350x150",
                              fit: BoxFit.fill,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: (widget.rentedStatus == null)
                                  ? ElevatedButton.styleFrom(
                                      primary: kAccentColor1)
                                  : (widget.rentedStatus == "Accepted")
                                      ? ElevatedButton.styleFrom(
                                          primary: notifiAccepted)
                                      : (widget.rentedStatus == "Denied")
                                          ? ElevatedButton.styleFrom(
                                              primary: notifiDenied)
                                          : ElevatedButton.styleFrom(
                                              primary: notifiSent),
                              onPressed: (widget.product.owner == username)
                                  ? () {
                                      var route = MaterialPageRoute(
                                          builder: (context) => EditListingPage(
                                              type: widget.item,
                                              interval: widget.product.interval,
                                              price: widget.product.price,
                                              category: widget.product.category,
                                              description:
                                                  widget.product.description,
                                              url: widget.product.url,
                                              itemID: widget.product.itemID,
                                              title: widget.product.title));
                                      Navigator.of(context).push(route);
                                    }
                                  : (widget.rentedStatus == null)
                                      ? () async {
                                          String notifiID = await notifiService
                                              .postNotification(
                                                  widget.product.title,
                                                  "Request Raised",
                                                  widget.product.owner,
                                                  widget.product.itemID);
                                          setState(() {
                                            widget.rentedStatus =
                                                "Request Raised";
                                            widget.notifiID = notifiID;
                                          });
                                        }
                                      : (widget.rentedStatus == "Accepted")
                                          ? () {
                                              String owner =
                                                  widget.product.owner;
                                              VoidCallback continueCallBack =
                                                  () => {
                                                        Navigator.of(context)
                                                            .pop(),
                                                        // code on Okay comes here
                                                      };
                                              BlurryDialog alert = BlurryDialog(
                                                  "Hooray!🎉",
                                                  "$owner has accepted you request to rent the item!",
                                                  continueCallBack,
                                                  false);

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            }
                                          : (widget.rentedStatus == "Denied")
                                              ? () {
                                                  String owner =
                                                      widget.product.owner;
                                                  VoidCallback
                                                      continueCallBack = () => {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                            // code on Okay comes here
                                                          };
                                                  BlurryDialog alert = BlurryDialog(
                                                      "Alas😞",
                                                      "$owner has denied you request to rent the item.",
                                                      continueCallBack,
                                                      false);

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                }
                                              : () {
                                                  VoidCallback
                                                      continueCallBack = () => {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                            notifiService
                                                                .deleteNotificaiton(
                                                                    widget
                                                                        .notifiID),
                                                            setState(() {
                                                              widget.rentedStatus =
                                                                  null;
                                                            })
                                                          };
                                                  BlurryDialog alert = BlurryDialog(
                                                      "Undo?",
                                                      "Do you want to undo your request to rent this item?",
                                                      continueCallBack,
                                                      true);

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: (widget.product.owner == username)
                                    ? Text(
                                        "Edit Item",
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w900),
                                      )
                                    : (widget.rentedStatus == null)
                                        ? Text(
                                            "Rent Item",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w900),
                                          )
                                        : (widget.rentedStatus == "Accepted")
                                            ? Text(
                                                "Accepted!",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )
                                            : (widget.rentedStatus == "Denied")
                                                ? Text(
                                                    "Denied",
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                : Text(
                                                    "Notification Sent",
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kAccentColor2),
                              onPressed: () {
                                var route = MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          username: username,
                                          chatID: "chatID",
                                          chatee: "someone who is not tester1",
                                        ));
                                Navigator.of(context).push(route);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Chat with ${widget.product.owner}",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900),
                                  )))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
