import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/pages/components/UserInfoCard.dart';

class HorizontalCardViewBuilder extends StatelessWidget {
  HorizontalCardViewBuilder({
    Key key,
    @required this.res,
    this.type,
  }) : super(key: key);

  final List<SingleItem> res;
  final String type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (res == null)
          ? Center(child: CircularProgressIndicator())
          : (res.length == 0)
              ? Center(child: Text("Nothing to show here"))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: res.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print(res[index].itemID);
                          var route = MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    itemID: res[index].itemID,
                                    item: type,
                                  ));
                          Navigator.of(context).push(route);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    flex: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              url + res[index].url)),
                                    )),
                                Flexible(
                                  child: Text(res[index].title + "",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
    );
  }
}
