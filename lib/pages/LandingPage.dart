import 'package:flutter/material.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String email;
  bool loading = true;
  Future<int> checklogin(email) async {
    print(email);
    final String url = DotEnv.env['SERVER_URL'];
    http.Response response = await http.post(
      Uri.https(url, "users/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'username': email}),
    );
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'jwt', value: jsonData["token"]);
    }

    // Navigator.pushNamed(context, '/home');
    return (response.statusCode);
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
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                int resCode = await checklogin(email);
                                if (resCode == 200) {
                                  Navigator.pushNamed(context, '/home');
                                } else {
                                  VoidCallback continueCallBack = () => {
                                        Navigator.of(context).pop(),
                                        // code on Okay comes here
                                      };
                                  BlurryDialog alert = BlurryDialog(
                                      "Login Failed",
                                      "Incorrect email",
                                      continueCallBack);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }
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
// http://159.89.164.229:5000/users/login
