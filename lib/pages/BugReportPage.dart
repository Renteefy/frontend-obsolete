import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/shared/alertBox.dart';

class BugReportPage extends StatefulWidget {
  @override
  _BugReportPageState createState() => _BugReportPageState();
}

final store = FlutterSecureStorage();

class _BugReportPageState extends State<BugReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController desController = new TextEditingController();
  bool loading = false;

  void sendMail(String title, String description) async {
    String username = env["USERNAME"];
    String password = env["PASSWORD"];

    String sender = await store.read(key: "username");
    setState(() {
      loading = true;
    });

    final smtpServer = gmail(username, password);
    final equivalentMessage = Message()
      ..from = Address(username, 'Bug Man Hug Man')
      ..recipients.add(Address('renteefy.bugs@gmail.com'))
      ..subject = 'Bug Report : ${DateTime.now()} : ${username} : ${sender}'
      ..html = "<h1>${title}</h1> <br> ${description}";

    await send(equivalentMessage, smtpServer);
  }

  Future<bool> rateLimiter() async {
    String previous = await store.read(key: "bugReport");
    final currentTime = DateTime.now();

    if (previous == null) {
      await store.write(key: 'bugReport', value: currentTime.toString());
      return false;
    }

    final timeDifference =
        currentTime.difference(DateTime.parse(previous)).inMinutes;
    if (timeDifference < 5) {
      return true;
    } else {
      await store.write(key: 'bugReport', value: currentTime.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text("Feedback and" + " ",
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w900)),
            Text("Bugs",
                style: GoogleFonts.inter(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reach us out",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Something went wrong? We can try helping. Report bugs or send hugs. Both are accepted here.",
                      style: GoogleFonts.inter(fontSize: 15, color: notifiSent),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Title Required';
                        }

                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Description Required';
                        }
                        return null;
                      },
                      controller: desController,
                      minLines: 10,
                      maxLines: 50,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    bool isRateLimited = await rateLimiter();
                    if (isRateLimited) {
                      VoidCallback continueCallBack = () => {
                            Navigator.of(context).pushNamed("/home")
                            // code on Okay comes here
                          };
                      BlurryDialog alert = BlurryDialog(
                          "Oops, too fast there",
                          "You have sent a bug report too often, please wait",
                          continueCallBack,
                          false);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      sendMail(titleController.text, desController.text);
                      Navigator.of(context).pushNamed("/home");
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: kAccentColor1),
                  child: (loading)
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Submit Report",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Icon(Icons.arrow_right_alt),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mail us at",
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text("renteefy.company@gmail.com",
                                style: GoogleFonts.inter(
                                    fontSize: 19,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w900)),
                            IconButton(
                                icon: Icon(Icons.copy_rounded),
                                onPressed: () async {
                                  ClipboardData data = ClipboardData(
                                      text: 'renteefy.company@gmail.com');
                                  await Clipboard.setData(data);
                                  final snackBar = SnackBar(
                                    content: Text('Copied to Clipboard'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
