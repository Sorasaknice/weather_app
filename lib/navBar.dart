import 'package:flutter/material.dart';

class navBar extends StatefulWidget {
  navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBar();
}


class _navBar extends State<navBar> {
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    PageController navController = PageController();

    void onTepped(int index){
      setState( (){
        selectedIndex= index;
      });
      navController.jumpToPage(index);
    }

    return Scaffold(
      body: PageView(
        controller: navController,
        children: [

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Home'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.cyan,
      ),
    );
  }
}
