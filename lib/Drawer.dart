import 'package:flutter/material.dart';
import 'package:projecttermapp/devMembers.dart';
import 'package:projecttermapp/map.dart';
import 'package:projecttermapp/weatherPage.dart';

class  widgetDrawer extends StatelessWidget {
  const widgetDrawer ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('Weather Page'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => weatherPage()));
              },
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Map Page'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pageMap()));
              },
              leading: Icon(Icons.map_rounded),
            ),
            ListTile(
              title: Text('Dev Page'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Devpage()));
              },
              leading: Icon(Icons.toll_outlined),
            )
          ],
        )
    );
  }
  
}