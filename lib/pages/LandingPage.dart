import 'package:flutter/material.dart';
import '../shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String email;
  bool loading = true;
  Future<int> checklogin(email) async {
    print(email);
    Navigator.pushNamed(context, '/home');
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome to",
                          style: GoogleFonts.inter(
                              fontSize: 36, fontWeight: FontWeight.w900)),
                      Text(
                        "Renteefy",
                        style: GoogleFonts.inter(
                            fontSize: 36,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                checklogin(email);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kAccentColor1),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Let's go!",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Icon(Icons.arrow_right_alt_rounded)
                                    ],
                                  ))))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/landing.png"),
                        fit: BoxFit.cover)),
              ))
        ],
      ),
    );
  }
}
