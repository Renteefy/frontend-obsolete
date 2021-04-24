import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/UserHttpService.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  bool loading = false;
  bool loadingOTP = false;

  final httpService = UserHttpService();
  Future<void> saveTokenToDatabase(String username) async {
    String token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .set({"token": token});
  }

  void onVerified() async {
    bool isVerified = await httpService.checkVerified(
        emailController.text, otpController.text);
    if (isVerified) {
      saveTokenToDatabase(emailController.text);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("OTP Verification Failed"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    void handlePress() async {
      setState(() {
        loading = true;
      });
      bool isAuth = await httpService.checkInvite(emailController.text);

      if (isAuth) {
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OTP Verification"),
                      Text("Please verify your email account"),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: otpController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'OTP',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                onVerified();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kAccentColor1),
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: (loadingOTP)
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Verify OTP",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ))))
                    ],
                  ),
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Okay")),
                ],
                title: Text("Look we love you but..."),
                content: Text(
                    "This app is presently for invited users only. Unfortunately, we do not see you on the invite list. Stay tuned for the first public release."),
              );
            });
      }
      // if (isAuth) {
      //    saveTokenToDatabase(email);
      //    Navigator.pushReplacementNamed(context, '/home');
      // } else {
      //   setState(() {
      //     loading = false;
      //   });
      //   VoidCallback continueCallBack = () => {
      //         Navigator.of(context).pop(),
      //         // code on Okay comes here
      //       };
      //   BlurryDialog alert = BlurryDialog(
      //       "Look, We love you. ❤️",
      //       "This app is presently for invited users only. Unfortunately, we do not see you on the invite list. Stay tuned for the first public release.",
      //       continueCallBack,
      //       false);

      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return alert;
      //     },
      //   );
      // }
    }

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
                        controller: emailController,
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
                              onPressed: handlePress,
                              style: ElevatedButton.styleFrom(
                                  primary: kAccentColor1),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: (loading)
                                      ? CircularProgressIndicator()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
