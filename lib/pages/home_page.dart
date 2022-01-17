
import 'package:flutter/material.dart';
import 'package:ithra/pages/cat_page.dart';
import 'package:ithra/pages/subscribe_page.dart';
import 'package:ithra/pages/setting.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int _index = 0;

 static  List<Widget> _widgetOptions = <Widget>[
   Home(),
   CatPage(),
   Subscribe(),
   Settings(),

 ];
  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      body: SafeArea(
        child: Center(
          child:_widgetOptions.elementAt(_index),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
              color: Colors.black,
            ),
            label: ('الرئيسية'),
          ),
          BottomNavigationBarItem(
           icon: Icon(
              Icons.tv,
              size: 20,
             color: Colors.black,
            ),
            label: ('البرامج'),

         ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 20,
              color: Colors.black,
            ),
            label: ('المفضلة'),

          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz,
              size: 20,
              color: Colors.black,

            ),
            label: ('المزيد'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _index =index;
          });
        },
      ),
    ));
  }
}

