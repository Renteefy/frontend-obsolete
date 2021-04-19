import 'package:flutter/material.dart';
import 'package:frontend/pages/LandingPage.dart';
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

Future<String> getUsername() async {
  var tmp = await store.read(key: "username");
  return tmp;
}

void sendPatchRequest(String firstName, String lastName, String username,
    String tmpUrl, context, bool goHome) async {
  int postRes = await UserHttpService()
      .patchUserDetails(firstName, lastName, username, tmpUrl);
  if (postRes == 200) {
    VoidCallback continueCallBack = () {
      if (goHome) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LandingPage()));
      }

      // code on Okay comes here
    };
    BlurryDialog alert = BlurryDialog(
        "Success", "Listing updated successfully", continueCallBack, false);

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
    BlurryDialog alert = BlurryDialog("Failure",
        "Something went wrong, Please try again", continueCallBack, false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

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
      url = (pickedFile != null) ? pickedFile.path : widget.url;
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
                    // to check if the username is changed
                    String oldUsername = await getUsername();
                    String tmpUrl = (newImagePicked) ? url : null;
                    if (usernameController.text != oldUsername) {
                      VoidCallback continueCallBack = () => {
                            sendPatchRequest(
                                firstNameController.text,
                                lastNameController.text,
                                usernameController.text,
                                tmpUrl,
                                context,
                                false),
                            Navigator.of(context).pop()
                            // code on Okay comes here
                          };
                      BlurryDialog alert = BlurryDialog(
                          "Warning",
                          "Since you have changed the username, you'll have to login again",
                          continueCallBack,
                          true);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      sendPatchRequest(
                          firstNameController.text,
                          lastNameController.text,
                          usernameController.text,
                          tmpUrl,
                          context,
                          true);
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
