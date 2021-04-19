import 'package:flutter/material.dart';
import 'package:frontend/services/UserHttpService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' as io;
import 'package:frontend/shared/alertBox.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String url;
  final String username;
  const EditProfile(
      {Key key, this.username, this.firstName, this.lastName, this.url})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

final store = new FlutterSecureStorage();

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  String url;
  bool newImagePicked = false;

  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      url = (pickedFile != null) ? pickedFile.path : null;
      newImagePicked = true;
    });
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    usernameController.text = widget.username;
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
                          ? AssetImage(url)
                          : (url != "/static/null")
                              ? NetworkImage(
                                  "https://" + env['SERVER_URL'] + url,
                                )
                              : NetworkImage(
                                  "https://ui-avatars.com/api/?name=Display+Picture")),
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
                      return 'Username Required';
                    }

                    return null;
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Username',
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
                    int postRes = await UserHttpService().patchUserDetails(
                        firstNameController.text,
                        lastNameController.text,
                        usernameController.text,
                        tmpUrl);
                    if (postRes == 200) {
                      await store.write(
                        key: 'username',
                        value: usernameController.text,
                      );
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
                        Text("Update Profile",
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
