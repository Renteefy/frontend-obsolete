import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String type = "Asset";
  String interval;
  File file;
  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = (pickedFile != null) ? File(pickedFile.path) : null;
      print(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Add  ",
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.w900)),
                Text("Listings",
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Rent your assets/items on Renteefy",
              style: GoogleFonts.inter(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 10),
            Text(
                "alesuada tempus efficitur. Duis at facilisis diam. Pellentesque purus enim, mattis vitae massa sed, ultrices efficitur dui. Proin pulvinar dapibus faucibus. Proin nec gravida "),
            SizedBox(height: 30),
            Text(
              "What do you want to rent?",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            RadioListTile(
              value: "Asset",
              groupValue: type,
              title: Text("Asset"),
              subtitle: Text("Physical entities"),
              onChanged: (val) {
                print("Radio Tile pressed $val");
                setState(() {
                  type = val;
                });
              },
              activeColor: kAccentColor1,
              selected: (type == "Asset") ? true : false,
            ),
            RadioListTile(
              value: "Service",
              groupValue: type,
              title: Text("Service"),
              subtitle: Text("Intangible entities"),
              onChanged: (val) {
                print("Radio Tile pressed $val");
                setState(() {
                  type = val;
                });
              },
              selected: (type == "Service") ? true : false,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                filled: true,
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 15),
            TextField(
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
            SizedBox(height: 15),
            TextFormField(
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
                        child: Image.file(file))
                    : ElevatedButton(
                        onPressed: pickImage,
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Add Some Pictures",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: kAccentColor1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Submit Listing",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
