import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WoInputWalaText extends StatefulWidget {
  @override
  _WoInputWalaTextState createState() => _WoInputWalaTextState();
}

String email;

Future<int> checkLogin(email) async {
  var match = {"username": email};
  var data = await http.post(Uri.http("127.0.0.1:5000", "users/login"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: match);
  // var jsonData = json.decode(data.body);

  return (data.statusCode);
}

class _WoInputWalaTextState extends State<WoInputWalaText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              fillColor: Color(0xff434040),
              filled: true,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff434040), width: 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff434040), width: 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff434040), width: 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff434040), width: 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Email",
              contentPadding: EdgeInsets.all(20),
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3cdbd3), // background
                  // onPrimary: Colors.white, // foreground
                ),
                onPressed: () async {
                  print(email);
                  var statusCode = await checkLogin(email);
                  if (statusCode == 200) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert Dialog Box"),
                            content: Text("Login Successful"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Ok"),
                              )
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert Dialog Box"),
                            content: Text("Login Unsuccessful"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Bruh"),
                              )
                            ],
                          );
                        });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Text("Let's Go",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
