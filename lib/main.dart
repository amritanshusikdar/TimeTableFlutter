import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timetable/constants.dart';
import 'package:timetable/screens/import_timetables/import_timetables.dart';
import 'screens/homescreen/homescreen.dart';

void main() => runApp(TimeTable());

class TimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time Table",
      theme: ThemeData(fontFamily: 'ProductSans', brightness: Brightness.dark),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PersistentTabView(
        // backgroundColor: CupertinoColors.systemGrey.withOpacity(0.18),
        backgroundColor: Colors.grey.withOpacity(0.18),
        controller: PersistentTabController(initialIndex: 0),
        items: <PersistentBottomNavBarItem>[
          PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              titleFontSize: 20.0,
              activeColor: mCyanColor,
              inactiveColor: mLightRedColor),
          PersistentBottomNavBarItem(
              icon: Icon(Icons.add_box),
              title: "Import",
              titleFontSize: 20.0,
              activeColor: mLightOrange,
              inactiveColor: mLightRedColor)
        ],
        screens: <Widget>[HomeScreen(), ImportTimeTables()],
        onItemSelected: (index) => debugPrint("$index pressed!"),
      ),
    );
  }
}
