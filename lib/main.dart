import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
    MaterialApp(theme: ThemeData(brightness: Brightness.dark), home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

String _email;

class _MyAppState extends State<MyApp> {
  Future<int> checkLogin(_email) async {
    var match = {"username": _email};
    var data = await http.post(Uri.http("127.0.0.1:3000", "users/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: match);
    // var jsonData = json.decode(data.body);

    return (data.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    // const colour = const Color(0xfEF476f);
    return Scaffold(
        backgroundColor: Colors.black,
        // body: TodayView(),

        body: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    borderSide:
                        const BorderSide(color: Color(0xff434040), width: 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff434040), width: 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff434040), width: 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff434040), width: 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Email",
                  contentPadding: EdgeInsets.all(20),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff3cdbd3), // background
                      // onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      print(_email);
                      var statusCode = await checkLogin(_email);
                      if (statusCode == 200) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert Dialog Box"),
                                content: Text("Login Successful"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Ok"),
                                  )
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert Dialog Box"),
                                content: Text("Login Unsuccessful"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Bruh"),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Text("Let's Go",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ),
              Container(
                child: Image.network(
                  "https://i.imgur.com/gNf5rxI.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ));
  }
}

// link : https://i.imgur.com/gNf5rxI.png
//  style: GoogleFonts.inter( textStyle: TextStyle(color: Color(0xffEF476f),fontSize: 40.0,fontWeight: FontWeight.bold))
