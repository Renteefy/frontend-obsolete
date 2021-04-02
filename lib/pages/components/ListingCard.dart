import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingCard extends StatelessWidget {
  final AssetListing obj;
  ListingCard({
    @required this.obj,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      obj.url,
                      width: 151,
                      height: 162,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(obj.title,
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("₹" + obj.price,
                          style: GoogleFonts.inter(
                              color: kAccentColor2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(" " + obj.interval,
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor2),
                      onPressed: () {
                        print("pressed");
                        Navigator.pushNamed(context, "/productDetail",
                            arguments: {"assetID": obj.title});
                      },
                      child: Center(child: Text("Rent this"))),
                ],
              ),
            ),
          )),
    );
  }
}
