import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/constants.dart';

class ImportTimeTables extends StatefulWidget {
  @override
  _ImportTimeTablesState createState() => _ImportTimeTablesState();
}

class _ImportTimeTablesState extends State<ImportTimeTables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      appBar: AppBar(
        title: Text("Import TimeTables"),
        backgroundColor: mOffWhiteColor.withOpacity(0.07),
        elevation: 10,
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Import new TimeTables from here!",
            style: TextStyle(
              color: mTextColor,
              fontSize: 40.0,
              backgroundColor: CupertinoColors.activeOrange,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
