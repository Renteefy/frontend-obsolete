import 'package:flutter/material.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/UserHttpService.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String email;
  bool loading = false;
  final httpService = UserHttpService();

  @override
  Widget build(BuildContext context) {
    void handlePress() async {
      setState(() {
        loading = true;
      });
      bool isAuth = await httpService.checkInvite(email);

      if (isAuth) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          loading = false;
        });
        VoidCallback continueCallBack = () => {
              Navigator.of(context).pop(),
              // code on Okay comes here
            };
        BlurryDialog alert = BlurryDialog(
            "Look, We love you. ❤️",
            "This app is presently for invited users only. Unfortunately, we do not see you on the invite list. Stay tuned for the first public release.",
            continueCallBack);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
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
