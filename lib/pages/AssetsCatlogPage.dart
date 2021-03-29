import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetCatlogPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
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
                    IconButton(icon: Icon(Icons.sort), onPressed: () {}),
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
                      ListingCard(),
                      ListingCard(),
                      ListingCard(),
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
  const ListingCard({
    Key key,
  }) : super(key: key);

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
                      "https://4.imimg.com/data4/VO/DP/MY-3816229/harry-potter-and-the-cursed-child-parts-i-500x500.jpg",
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
                  Text("50 rs per hour"),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor2),
                      onPressed: () {},
                      child: Center(child: Text("Rent This"))),
                ],
              ),
            ),
          )),
    );
  }
}
