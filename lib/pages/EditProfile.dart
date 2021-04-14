import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' as io;
import 'package:frontend/shared/alertBox.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String url;
  final String email;
  const EditProfile(
      {Key key, this.email, this.firstName, this.lastName, this.url})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String url;
  bool newImagePicked = false;

  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      url = (pickedFile != null) ? pickedFile.path : null;
      newImagePicked = true;
      print(url);
    });
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    emailController.text = widget.email;
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text("Edit ",
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w900)),
            Text("Profile",
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
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: CircleAvatar(
                      radius: 120.0,
                      backgroundImage: (io.File(url).existsSync())
                          ? Image.file(io.File(url))
                          : NetworkImage(
                              "https://" + env['SERVER_URL'] + url,
                            )),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Change Picture  ",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ))),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'First Name Required';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'First Name',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Last Name Required';
                    }

                    return null;
                  },
                  controller: lastNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Last Name',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email Required';
                    }

                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    // Change this to patch asset
                    String tmpUrl = (newImagePicked) ? url : null;
                    int postRes = 200;
                    if (postRes == 200) {
                      VoidCallback continueCallBack = () => {
                            Navigator.pushReplacementNamed(context, '/home')
                            // code on Okay comes here
                          };
                      BlurryDialog alert = BlurryDialog(
                          "Success",
                          "Listing updated successfully",
                          continueCallBack,
                          false);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      VoidCallback continueCallBack = () => {
                            Navigator.of(context).pop(),
                            // code on Okay comes here
                          };
                      BlurryDialog alert = BlurryDialog(
                          "Failure",
                          "Something went wrong, Please try again",
                          continueCallBack,
                          false);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: kAccentColor1),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Submit Listing",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        Icon(Icons.arrow_right_alt),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
