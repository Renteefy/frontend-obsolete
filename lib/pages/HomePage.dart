import 'package:flutter/material.dart';
import 'package:frontend/models/GlobalState.dart';

import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/pages/CatalogPage.dart';
import 'package:provider/provider.dart';

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
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus malesuada tempus efficitur. Duis at facilisis diam. Pellentesque purus enim, mattis vitae massa sed, ultrices efficitur dui. Proin pulvinar dapibus faucibus. Proin nec gravida "),
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
              Consumer(
                  builder: (BuildContext context, GlobalState globalState, _) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor1),
                      onPressed: () {
                        globalState.incrementCounter();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "What are cows?",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                );
              })
            ],
          ),
        ));
  }
}
