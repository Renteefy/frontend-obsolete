import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:frontend/shared/constants.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/AssetsHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final assetService = AssetsHttpService();
  SingleAsset asset;

  void fetchAsset(String assetID) async {
    SingleAsset tmp = await assetService.getSingleAsset(assetID);
    setState(() {
      asset = tmp;
    });
  }

  final String url = "https://" + env['SERVER_URL'];
  // final String url = "http://" + "127.0.0.1:5000";
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    if (flag == true) {
      fetchAsset(routes["assetID"]);
      setState(() {
        flag = false;
      });
    }

    // print(routes["assetID"]);
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
      body: SingleChildScrollView(
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
                        ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.network(url + asset.url)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          asset.title,
                          style: GoogleFonts.inter(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          asset.description,
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
                              asset.price + " ",
                              style: GoogleFonts.inter(
                                  color: kPrimaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              asset.interval,
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
                                style: ElevatedButton.styleFrom(
                                    primary: kAccentColor1),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Rent item",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900),
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Chat with Owner",
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
      ),
    );
  }
}
