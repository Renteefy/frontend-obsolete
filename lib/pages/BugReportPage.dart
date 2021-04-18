import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BugReportPage extends StatefulWidget {
  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController desController = new TextEditingController();
  bool loading = false;
  void sendMail(String title, String description) async {
    String username = env["USERNAME"];
    String password = env["PASSWORD"];
    final store = FlutterSecureStorage();
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
          child: Container(
            child: Column(
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
                  height: 40,
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    sendMail(titleController.text, desController.text);
                    Navigator.of(context).pushNamed("/home");
                  },
                  style: ElevatedButton.styleFrom(primary: kAccentColor1),
                  child: (loading)
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Submit Listing",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Icon(Icons.arrow_right_alt),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
