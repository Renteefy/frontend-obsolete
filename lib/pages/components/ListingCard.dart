import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/pages/ProductDetails.dart';
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
    return GestureDetector(
      onTap: () {
        print(obj.assetID);
        var route = MaterialPageRoute(
            builder: (context) => ProductDetails(
                  assetID: obj.assetID,
                ));
        Navigator.of(context).push(route);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff363636),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(url + obj.url),
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      obj.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "₹" + obj.price + " " + obj.interval,
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
