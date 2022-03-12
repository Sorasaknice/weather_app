
import 'package:flutter/material.dart';
import 'package:projecttermapp/weatherPage.dart';
import 'package:projecttermapp/devMembers.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: MyApp() ,
      theme: ThemeData(fontFamily: 'NotoSansThai'),
    ),
  );
}

final usenameText = TextEditingController();
final passewordText = TextEditingController();

Future userLogin( BuildContext context) async {

  String username = usenameText.text;
  String password = passewordText.text;

  print(username);
  print(password);

  var url = 'http://202.28.34.207/api2/checklogin2.php';

  // Store all data with Param Name.
  var data = {'email': username, 'password': password};

  // Starting Web API Call.
  var response = await http.post(Uri.parse(url), body: jsonEncode(data));

  // Getting Server response into variable.
  Map<String, dynamic> result = jsonDecode(response.body);

  print(result);

  if (result['status'] != '') {
      // Navigate to Profile Screen & Sending Email to Next Screen.
          Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => weatherPage()));
  }else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(result['message']),
            actions: <Widget>[
              TextButton(
                child: new Text("ตกลง"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600,
            width: 500,
            padding: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset('image/weather.png'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: usenameText ,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'username'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: passewordText ,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'password'),
                ),
              ),
              SizedBox(width: 100,),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                // ignore: deprecated_member_use
                child: ElevatedButton.icon(
                label: Text('เข้าสู่ระบบ'),
                onPressed: () {
                  userLogin(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.login_outlined),
              )
              )
            ]),
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/weatherpage': (BuildContext context) => new weatherPage(),
      },
    );
  }
}
