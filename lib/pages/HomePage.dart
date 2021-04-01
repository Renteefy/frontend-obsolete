import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Welcome to ",
                      style: GoogleFonts.inter(
                          fontSize: 24, fontWeight: FontWeight.w900)),
                  Text("Renteefy",
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w900)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus malesuada tempus efficitur. Duis at facilisis diam. Pellentesque purus enim, mattis vitae massa sed, ultrices efficitur dui. Proin pulvinar dapibus faucibus. Proin nec gravida "),
              Center(child: Image.asset("assets/home.png")),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/assetCatalog');
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
                    onPressed: () {},
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
              )
            ],
          ),
        ));
  }
}
