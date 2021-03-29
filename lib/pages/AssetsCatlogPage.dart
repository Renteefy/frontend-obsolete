import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetCatlogPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // Add sorting code here
    void onSortPressed() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(Icons.ac_unit),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                ),
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  icon: Icon(Icons.notifications_none_rounded),
                  iconSize: 30,
                  onPressed: () {}),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Rent ",
                        style: GoogleFonts.inter(
                            fontSize: 24, fontWeight: FontWeight.w900)),
                    Text("Assets",
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          print(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Search Asset',
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () => onSortPressed()),
                  ],
                ),
                SizedBox(height: 50),
                Text("All Listings",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ListingCard(
                        title:
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit",
                        interval: "per hour",
                        price: "50",
                      ),
                      ListingCard(
                        title:
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit",
                        interval: "per hour",
                        price: "50",
                      ),
                      ListingCard(
                        title:
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit",
                        interval: "per hour",
                        price: "50",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ListingCard extends StatelessWidget {
  final String url;
  final String title;
  final String price;
  final String interval;
  ListingCard(
      {this.url = "https://via.placeholder.com/151/162",
      @required this.title,
      @required this.price,
      @required this.interval});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 380,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
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
                      url,
                      width: 151,
                      height: 162,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit ",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("₹" + price,
                          style: GoogleFonts.inter(
                              color: kAccentColor2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(" " + interval,
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor2),
                      onPressed: () {},
                      child: Center(child: Text("Rent this"))),
                ],
              ),
            ),
          )),
    );
  }
}
