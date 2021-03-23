import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // const colour = const Color(0xfEF476f);
    return MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(
            backgroundColor: Colors.black,
            // body: TodayView(),

            body: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text("Welcome to",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold))),
                  Text("Renteefy",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: Color(0xffEF476f)))),
                  SizedBox(height: 30),
                  Text("Hey there,",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  Text("Join the private party",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold))),
                  SizedBox(height: 50),
                  TextField(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xff434040),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff434040), width: 0.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(20),
                      ))
                ],
              ),
            )));
  }
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
