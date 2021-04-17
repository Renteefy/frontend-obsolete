import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/shared/alertBox.dart';
import "dart:io";

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
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

class _AddPageState extends State<AddPage> {
  String type = "asset";
  String interval;
  String category;
  TextEditingController titleController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  String file;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = (pickedFile != null) ? pickedFile.path : null;
      print("filename: " + file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              SizedBox(
                  width: double.infinity,
                  child: (file != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(File(file)))
                      : ElevatedButton(
                          onPressed: pickImage,
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add Some Pictures  ",
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
                              )))),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  int postRes = await ItemsHttpService().postItem(
                      titleController.text,
                      descriptionController.text,
                      file,
                      priceController.text,
                      interval,
                      category,
                      type.toLowerCase());
                  if (postRes == 200) {
                    VoidCallback continueCallBack = () => {
                          Navigator.pushReplacementNamed(context, '/home')
                          // code on Okay comes here
                        };
                    BlurryDialog alert = BlurryDialog(
                        "Success",
                        "Listing submitted successfully",
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
        ));
  }
}
