import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteUser extends StatefulWidget {
  @override
  _InviteUserState createState() => _InviteUserState();
}

class _InviteUserState extends State<InviteUser> {
  List<String> emailList = [];
  TextEditingController emailController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailList.add("yojat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text("Invite ",
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w900)),
            Text("Users",
                style: GoogleFonts.inter(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_none_rounded),
              iconSize: 30,
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              }),
          SizedBox(width: 10),
          IconButton(
              icon: Icon(Icons.messenger_outline),
              iconSize: 28,
              onPressed: () {
                Navigator.pushNamed(context, '/chatListing');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let your friends know",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sharing is caring. Invite upto 3 of your friend/family to use Renteefy",
                style: GoogleFonts.inter(fontSize: 15, color: notifiSent),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset("assets/invite.png"),
              SizedBox(
                height: 10,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: "email pls",
                      filled: true,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          //print(messageController.text);
                          setState(() {
                            if (emailList.length == 3 ||
                                !EmailValidator.validate(
                                    emailController.text)) {
                            } else {
                              emailList.add(emailController.text);
                              emailController.clear();
                            }
                          });
                        },
                        icon: Icon(Icons.check),
                      )),
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : "Please enter a valid email",
                ),
              ),
              SizedBox(
                height: 40,
              ),
              (emailList.length == 0)
                  ? SizedBox()
                  : Text(
                      "People you have invited",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900, fontSize: 20),
                    ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: emailList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(emailList[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          color: kPrimaryColor,
                          onPressed: () {
                            setState(() {
                              emailList.remove(emailList[index]);
                            });
                          },
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
