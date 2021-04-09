import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/NotificationsHttpService.dart';

import 'package:frontend/shared/constants.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/AssetsHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/shared/alertBox.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final assetService = AssetsHttpService();
  SingleAsset asset;
  bool flag = false;
  bool rented = false;
  String notifID;

  Future<SingleAsset> fetchAsset(String assetID) async {
    SingleAsset tmp = await assetService.getSingleAsset(assetID);
    // I've used flag here because when I hadn't it was calling the api like 5 times per second
    if (!flag) {
      String abc = await NotificationHttpService().isAlreadyRented(tmp.title);
      flag = true;
      if (abc != "0") {
        setState(() {
          rented = true;
          notifID = abc;
        });
      }
    }
    return tmp;
  }

  final String url = "https://" + env['SERVER_URL'];
  // final String url = "http://" + "127.0.0.1:5000";

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
        appBar: AppBar(
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
        body: Container(
          child: FutureBuilder(
              future: fetchAsset(routes["assetID"]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(child: Text("Loading"));
                }
                return SingleChildScrollView(
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
                                        child: Image.network(
                                            url + snapshot.data.url)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data.title,
                                    style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data.description,
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
                                        snapshot.data.price + " ",
                                        style: GoogleFonts.inter(
                                            color: kPrimaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        snapshot.data.interval,
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
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      child: Image.network(
                                          "https://via.placeholder.com/350x150")),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: (rented)
                                              ? ElevatedButton.styleFrom(
                                                  primary: kAccentColor4)
                                              : ElevatedButton.styleFrom(
                                                  primary: kAccentColor1),
                                          onPressed: (rented)
                                              ? () async {
                                                  VoidCallback
                                                      continueCallBack = () => {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                            NotificationHttpService()
                                                                .deleteNotificaiton(
                                                                    notifID),
                                                            setState(() {
                                                              rented = false;
                                                            })
                                                          };

                                                  BlurryDialog alert =
                                                      BlurryDialog(
                                                    "Undo?",
                                                    "Do you want to undo the request?",
                                                    continueCallBack,
                                                  );

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                }
                                              : () async {
                                                  String postRes =
                                                      await NotificationHttpService()
                                                          .postNotification(
                                                              snapshot
                                                                  .data.title,
                                                              "Request Raised",
                                                              snapshot.data
                                                                  .username);
                                                  if (postRes != "0") {
                                                    setState(() {
                                                      notifID = postRes;
                                                      rented = true;
                                                    });
                                                  } else {
                                                    VoidCallback
                                                        continueCallBack =
                                                        () => {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                              // code on Okay comes here
                                                            };
                                                    BlurryDialog alert =
                                                        BlurryDialog(
                                                            "Failure",
                                                            "Something went wrong, Please try again",
                                                            continueCallBack);

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return alert;
                                                      },
                                                    );
                                                  }
                                                },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: (rented)
                                                ? Text(
                                                    "Request Sent",
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                : Text(
                                                    "Rent Item",
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
                                          onPressed: () {},
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                "Chat with Owner",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
