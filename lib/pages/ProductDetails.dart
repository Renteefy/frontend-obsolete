// these are the changes
import 'package:badges/badges.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/EditPage.dart';
import 'package:frontend/services/ChatHttpService.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/services/NotificationsHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/io.dart';

class ProductDetails extends StatefulWidget {
  final String itemID;
  final String item;
  const ProductDetails({Key key, this.itemID, this.item}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

final notifiService = NotificationHttpService();

bool isUserExcited(notifiTime) {
  final date2 = DateTime.now();
  final date1 = DateTime.parse(notifiTime);
  final difference = date2.difference(date1).inHours;
  return difference < 1;
}

class _ProductDetailsState extends State<ProductDetails> {
  final itemService = ItemsHttpService();
  String notifiID;

  SingleItem product;
  NotificationListing notifi;
  bool loading = true;
  String rentedStatus;

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
  final chatService = ChatHttpService();

  void tmpPostNotification(
      String title, String owner, String itemID, String item) async {
    String notifiID = await notifiService.postNotification(
        title, "Request Raised", owner, itemID, item);
    setState(() {
      widget.rentedStatus = "Request Raised";
      widget.notifiID = notifiID;
    });
  }

  String username;
  @override
  void initState() {
    super.initState();
    resolveUsername();
    print(widget.rentedStatus);
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
                            child: (widget.product.url != "/static/null")
                                ? Image.network(widget.url + widget.product.url)
                                : Image.network(
                                    "https://via.placeholder.com/150")),
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
                      Badge(
                        toAnimate: false,
                        shape: BadgeShape.square,
                        borderSide:
                            BorderSide(width: 1.3, color: kPrimaryColor),
                        badgeColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: Text(widget.product.category,
                            style: GoogleFonts.inter(fontSize: 15)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        widget.product.description,
                        style: GoogleFonts.inter(
                          color: notifiSent,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text("Listed by: ",
                              style: GoogleFonts.inter(
                                  color: notifiSent, fontSize: 17)),
                          Text(widget.product.owner,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rs. ",
                            style: GoogleFonts.inter(
                                color: notifiSent,
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
                          width: double.infinity, child: ramukaka(context)),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kAccentColor2),
                              onPressed: () async {
                                var chatList = await chatService.getChatRoom(
                                    username, widget.product.owner);

                                var route = MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          channel: IOWebSocketChannel.connect(
                                              ("wss://chat.renteefy.ga/ws?username=" +
                                                  username)),
                                          username: username,
                                          chatID: chatList.chatID,
                                          chatee: widget.product.owner,
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

  ElevatedButton ramukaka(BuildContext context) {
    // if the logged in user owns the asset
    if (widget.product.owner == username) {
      // Return the EDIT ITEM button
      return editItemButton(context);
    }

    // If the logged in user is not the owner, then they must be looking to rent
    else {
      // this is a new user, who has not sent a notification requesting to rent this product
      if (widget.rentedStatus == null && widget.product.renter == null) {
        return rentItemButton();
      }

      // if the user has already sent a notification requesting to rent this item and it is pending from the owner's end
      else if (widget.rentedStatus == "Request Raised") {
        return undoRequestButton(context);
      }

      // if the user has already sent a notification requesting to rent this item, but has been denied
      else if ((widget.rentedStatus == "Denied")) {
        return deniedButton(context);
      }

      // if the user has already sent a notification requesting to rent this item and the request has been ACCEPTED
      else if (widget.rentedStatus == "Accepted") {
        // There are two options if the request has been accepted:
        // 1 -> The user is excited -> show the ACCEPTED button
        // 2 -> The user is not excited -> show the RETURN ITEM button
        // Note: the excitement is checked by "isUserExcited" function

        if (isUserExcited(widget.notifi.date)) {
          return acceptedButton(context);
        } else {
          return returnItemButton(context);
        }
      }
      // The last option is that the item has already been rented, and hence it's out of stock
      else {
        return outOfStockButton();
      }
    }
  }

  ElevatedButton rentItemButton() {
    return ElevatedButton(
      onPressed: () {
        tmpPostNotification(widget.product.title, widget.product.owner,
            widget.product.itemID, widget.item);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Rent Item",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: kAccentColor1),
    );
  }

  ElevatedButton outOfStockButton() {
    return ElevatedButton(
        onPressed: null,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Out of Stock",
            style: GoogleFonts.inter(fontWeight: FontWeight.w900),
          ),
        ));
  }

  ElevatedButton returnItemButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        VoidCallback continueCallBack = () => {
              Navigator.pushReplacementNamed(context, '/home'),
              // code on Okay comes here
              ItemsHttpService()
                  .setRenter(widget.item, widget.product.itemID, null),
              notifiService.deleteNotificaiton(widget.notifiID),
            };
        BlurryDialog alert = BlurryDialog(
            "Return Item",
            "Are you sure you want to return the item?",
            continueCallBack,
            true);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Return Item",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: kAccentColor1),
    );
  }

  ElevatedButton acceptedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String owner = widget.product.owner;
        VoidCallback continueCallBack = () => {
              Navigator.of(context).pop(),
              // code on Okay comes here
            };
        BlurryDialog alert = BlurryDialog(
            "Hooray!🎉",
            "$owner has accepted you request to rent the item!",
            continueCallBack,
            false);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Accepted!",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: notifiAccepted),
    );
  }

  ElevatedButton deniedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String owner = widget.product.owner;
        VoidCallback continueCallBack = () => {
              Navigator.of(context).pop(),
              // code on Okay comes here
            };
        BlurryDialog alert = BlurryDialog(
            "Alas😞",
            "$owner has denied you request to rent the item.",
            continueCallBack,
            false);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Denied",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: notifiDenied),
    );
  }

  ElevatedButton undoRequestButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        VoidCallback continueCallBack = () => {
              Navigator.of(context).pop(),
              notifiService.deleteNotificaiton(widget.notifiID),
              setState(() {
                widget.rentedStatus = null;
              })
            };
        BlurryDialog alert = BlurryDialog(
            "Undo?",
            "Do you want to undo your request to rent this item?",
            continueCallBack,
            true);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Notification Sent",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: notifiSent),
    );
  }

  ElevatedButton editItemButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        var route = MaterialPageRoute(
            builder: (context) => EditListingPage(
                type: widget.item,
                interval: widget.product.interval,
                price: widget.product.price,
                category: widget.product.category,
                description: widget.product.description,
                url: widget.product.url,
                itemID: widget.product.itemID,
                title: widget.product.title));
        Navigator.of(context).push(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Edit Item",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900),
        ),
      ),
      style: ElevatedButton.styleFrom(primary: kAccentColor1),
    );
  }
}
