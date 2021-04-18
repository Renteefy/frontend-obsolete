import 'dart:io' as io;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditListingPage extends StatefulWidget {
  final String type;
  final String interval;
  final String price;
  final String category;
  final String description;
  final String url;
  final String title;
  final String itemID;

  const EditListingPage(
      {Key key,
      this.type,
      this.title,
      this.interval,
      this.price,
      this.category,
      this.description,
      this.itemID,
      this.url})
      : super(key: key);

  @override
  _EditListingPageState createState() => _EditListingPageState();
}

final assetCategories = [
  "Books and Stationary",
  "Furniture and Home Decor",
  "Hardware and Tools",
  "Technology and Electronics",
  "Clothing and Accessories",
  "Automobiles and Vehicles",
  "Others"
];

final serviceCategory = ["Teaching", "Driving", "Others"];

void deleteItem(String item, String itemID, context) async {
  int x = await ItemsHttpService().deleteItem(item, itemID);
  if (x != 1) {
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
  } else {
    VoidCallback continueCallBack = () => {
          Navigator.pushReplacementNamed(context, '/home')
          // code on Okay comes here
        };
    BlurryDialog alert = BlurryDialog(
        "Done", "Item Deleted Successfully", continueCallBack, false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _EditListingPageState extends State<EditListingPage> {
  String type;
  String url;
  String interval;
  String category;
  String itemID;
  TextEditingController titleController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    titleController.text = widget.title;
    type = widget.type;
    url = widget.url;
    interval = widget.interval;
    priceController.text = widget.price;
    descriptionController.text = widget.description;
    category = widget.category;
    itemID = widget.itemID;
    print(type);
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
            Text("Listing",
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
                Text(
                    "alesuada tempus efficitur. Duis at facilisis diam. Pellentesque purus enim, mattis vitae massa sed, ultrices efficitur dui. Proin pulvinar dapibus faucibus. Proin nec gravida "),
                SizedBox(height: 30),
                Text(
                  "What do you want to rent?",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                RadioListTile(
                  value: "asset",
                  groupValue: type,
                  title: Text("Asset"),
                  subtitle: Text("Physical entities"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setState(() {
                      type = val;
                      category = null;
                    });
                  },
                  activeColor: kAccentColor1,
                  selected: (type == "asset") ? true : false,
                ),
                RadioListTile(
                  value: "service",
                  groupValue: type,
                  title: Text("Service"),
                  subtitle: Text("Intangible entities"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setState(() {
                      type = val;
                      category = null;
                    });
                  },
                  selected: (type == "service") ? true : false,
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 15),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Price Required';
                    }

                    return null;
                  },
                  controller: priceController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Price',
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  color: Color(0xff1a1a1a),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      focusColor: kPrimaryColor,
                      value: interval,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        "per day",
                        "per hour",
                        "per week",
                        "per month",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ),
                        );
                      }).toList(),
                      icon: Icon(
                        // Add this
                        Icons.arrow_drop_down, // Add this
                        color: kAccentColor1,
                        size: 30,
                      ),
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Interval",
                          style: GoogleFonts.inter(fontSize: 15),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          interval = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  color: Color(0xff1a1a1a),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      focusColor: kPrimaryColor,
                      value: category,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: (type == "asset")
                          ? assetCategories
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                ),
                              );
                            }).toList()
                          : serviceCategory
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                ),
                              );
                            }).toList(),
                      icon: Icon(
                        // Add this
                        Icons.arrow_drop_down, // Add this
                        color: kAccentColor1,
                        size: 30,
                      ),
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Category",
                          style: GoogleFonts.inter(fontSize: 15),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          category = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(height: 20),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: (io.File(url).existsSync())
                        ? Image.file(io.File(url))
                        : Image.network("https://" + env['SERVER_URL'] + url)),
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
                              "Change Picture ",
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    // Change this to patch asset
                    String tmpUrl = (newImagePicked) ? url : null;
                    int postRes = await ItemsHttpService().patchItem(
                        titleController.text,
                        descriptionController.text,
                        tmpUrl,
                        priceController.text,
                        interval,
                        category,
                        itemID,
                        type.toLowerCase());
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    VoidCallback continueCallBack = () => {
                          // on pressed okay comes here
                          Navigator.of(context).pop(),
                          deleteItem(type, itemID, context)
                        };
                    BlurryDialog alert = BlurryDialog(
                        "Delete?",
                        "Do you want to delete this listing?",
                        continueCallBack,
                        true);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: notifiDenied),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Delete Listing",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
