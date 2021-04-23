import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/pages/CatalogPage.dart';

class HomePage extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey there! ",
                  style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Good to see you here. Make yourself at home. You can start renting from the listed items on Renteefy. So, what are we renting today?",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Center(child: Image.asset("assets/home.png")),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/assetCatalog');
                      var route = MaterialPageRoute(
                          builder: (context) => CatalogPage(
                                type: "asset",
                              ));
                      Navigator.of(context).push(route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Rent Assets",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentColor1),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/assetCatalog');
                      var route = MaterialPageRoute(
                          builder: (context) => CatalogPage(
                                type: "service",
                              ));
                      Navigator.of(context).push(route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Rent Services",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 10),
            ],
          ),
        ));
  }
}
