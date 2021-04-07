import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListingCard extends StatelessWidget {
  final AssetListing obj;
  ListingCard({
    @required this.obj,
  });

  @override
  Widget build(BuildContext context) {
    final String url = "https://" + env['SERVER_URL'];

    // final String url = "http://" + "127.0.0.1:5000";
    return SizedBox(
      height: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      url + obj.url,
                      width: 151,
                      height: 162,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(obj.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor2),
                      onPressed: () {
                        print("pressed");
                        print(obj.assetID);
                        Navigator.pushNamed(context, "/productDetail",
                            arguments: {"assetID": obj.assetID});
                      },
                      child: Center(child: Text("Rent this"))),
                ],
              ),
            ),
          )),
    );
  }
}
