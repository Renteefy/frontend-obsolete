import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  // use the assetID to fetch details from server for specific product
  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    print(routes["assetID"]);
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
                            child: Image.network(
                                "https://via.placeholder.com/350")),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: GoogleFonts.inter(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
                              "10" + " ",
                              style: GoogleFonts.inter(
                                  color: kPrimaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "per day",
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
