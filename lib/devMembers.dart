import 'package:flutter/material.dart';
import 'package:projecttermapp/Drawer.dart';

class Devpage extends StatelessWidget {
  const Devpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member Page',
      theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Member(),
    );
  }
}

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widgetDrawer(),
      appBar: AppBar(title: Text("Developer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 125,
                    backgroundImage: AssetImage("image/nice.jpg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("นายสรศักดิ์ กุลโคก"),
                  Text("รหัสนิสิต : 62011211090"),
                ],
              ),
            ),
            SizedBox(
              width: 1,
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 125,
                    backgroundImage: AssetImage("image/ice.jpg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("นายธนธรณ์ มีเสาเพ็ชร"),
                  Text("รหัสนิสิต : 62011211016")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
