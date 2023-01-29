import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final currentIndex=0;

    return BottomNavigationBar(
      showUnselectedLabels: false,
      selectedItemColor: Colors.deepPurple,
      //backgroundColor: Color.fromRGBO(55, 57, 84, 1),
      //unselectedItemColor: Color.fromRGBO(116, 117, 152, 1),
      elevation: 0,
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones'
        ),

      ],
    );
  }
}