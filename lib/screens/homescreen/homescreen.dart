import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:timetable/constants.dart';
import '../days/days.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  PageController _pageController;
  TextEditingController _subjectTextEditingController;
  int _currentPage = DateTime.now().weekday - 1;
  String _weekday;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: DateTime.now().weekday - 1);
    _subjectTextEditingController = new TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _subjectTextEditingController.dispose();
    super.dispose();
  }

  Map<int, Map<String, Map<TimeOfDay, Duration>>> _timeMap = {
    sundayConstInt: {},
    mondayConstInt: {},
    tuesdayConstInt: {},
    wednesdayConstInt: {
      "Physics": {TimeOfDay(hour: 23, minute: 58): Duration(minutes: 1)},
      "Chemistry": {TimeOfDay(hour: 23, minute: 59): Duration(minutes: 2)}
    },
    thursdayConstInt: {},
    fridayConstInt: {},
    saturdayConstInt: {},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: mBackgroundColor,
      appBar: AppBar(
        title: Text("Time Table"),
        centerTitle: true,
        backgroundColor: mOffWhiteColor.withOpacity(0.07),
        elevation: 10,
        leading: Icon(CupertinoIcons.game_controller_solid),
        actions: <Widget>[
          Icon(Icons.leak_add),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: PageView(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (pageNumber) {
            setState(() {
              _currentPage = pageNumber;
              print("_currentPage: $_currentPage");
            });
          },
          children: <Widget>[
//            MONDAY
            MakeDayPage (
                timeTable: _timeMap[mondayConstInt],
                title: mondayConstString,
                gradientColors: mondayGradientColors),
//            TUESDAY
            MakeDayPage(
                timeTable: _timeMap[tuesdayConstInt],
                title: tuesdayConstString,
                gradientColors: tuesdayGradientColors),
//            WEDNESDAY
            MakeDayPage(
                timeTable: _timeMap[wednesdayConstInt],
                title: wednesdayConstString,
                gradientColors: wednesdayGradientColors),
//            THURSDAY
            MakeDayPage(
                timeTable: _timeMap[thursdayConstInt],
                title: thursdayConstString,
                gradientColors: thursdayGradientColors),
//            FRIDAY
            MakeDayPage(
                timeTable: _timeMap[fridayConstInt],
                title: fridayConstString,
                gradientColors: fridayGradientColors),
//            SATURDAY
            MakeDayPage(
                timeTable: _timeMap[saturdayConstInt],
                title: saturdayConstString,
                gradientColors: saturdayGradientColors),
//            SUNDAY
            MakeDayPage(
                timeTable: _timeMap[sundayConstInt],
                title: sundayConstString,
                gradientColors: sundayGradientColors),
          ]),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Builder(
                builder: (context) => FloatingActionButton(
                  onPressed: () {
                    addItemToTimeTable();
                  },
                  backgroundColor: mLightOrange.withOpacity(0.87),
                  child: Icon(
                    Icons.add,
                    size: 46.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Builder(
                builder: (context) => FloatingActionButton.extended(
                  backgroundColor: mPurpleColor,
                  icon: Icon(
                    Icons.today,
                    size: 30.0,
                  ),
                  label: Text(
                    "TODAY",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    showToday(DateTime.now().weekday - 1);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Today is $_weekday!",
                        style: TextStyle(color: CupertinoColors.systemTeal),
                      ),
                      duration: Duration(milliseconds: 2000),
                      backgroundColor: CupertinoColors.black,
                    ));
                  },
                ),
              ),
            ),
          ]),
    );
  }

  void showToday(int _weekday) {
    debugPrint("${_weekday.toString()} ${this._weekday.toString()}");
    switch (_weekday) {
      case 0:
        this._weekday = mondayConstString;
        break;
      case 1:
        this._weekday = tuesdayConstString;
        break;
      case 2:
        this._weekday = wednesdayConstString;
        break;
      case 3:
        this._weekday = thursdayConstString;
        break;
      case 4:
        this._weekday = fridayConstString;
        break;
      case 5:
        this._weekday = saturdayConstString;
        break;
      case 6:
        this._weekday = sundayConstString;
        break;
      default:
        this._weekday = "#INV_DAY!";
        break;
    }
    _pageController.animateToPage(_weekday,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOutExpo);
  }

  void addItemToTimeTable() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String formattedTime = "Select Time";
        TimeOfDay selectedTime = new TimeOfDay(hour: null, minute: null);
        Duration duration = new Duration(hours: 0, minutes: 0);
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
          return AlertDialog(
            title: Text("Add a Subject"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _subjectTextEditingController,
//  TODO turn it back ON later
                  // autofocus: true,
                  decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.pen),
                      labelText: "Subject Name",
                      hintText: "eg: PHY, CS ..."),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
//  TODO:--> debug the ```formatTime``` on picking up new subject time
                      Text(formattedTime),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.blueGrey,
                        child: Text(
                          "Choose",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          TimeOfDay _timeValue = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (_timeValue != null) {
                            stateSetter(() {
                              selectedTime = _timeValue;
                              formattedTime =
                                  "Start @ ${_timeValue.hourOfPeriod}:${_timeValue.minute.toString().length != 2 ? "0${_timeValue.minute}" : "${_timeValue.minute}"} ${_timeValue.hour < 12 ? "AM" : "PM"}";
                              print("formattedTime: $formattedTime");
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${_formatDuration(duration)}"),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.blueGrey,
                        child: Text(
                          "Set",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height /
                                        3,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      minuteInterval: 1,
                                      initialTimerDuration: duration,
                                      onTimerDurationChanged:
                                          (Duration changedTime) {
                                        stateSetter(() {
                                          duration = changedTime;
                                        });
                                      },
                                    ));
                              });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      _timeMap[_currentPage].putIfAbsent(
                          _subjectTextEditingController.text,
                          () => {selectedTime: duration});
                      _subjectTextEditingController.clear();
                    });
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Item added successfully!"),
                      duration: Duration(milliseconds: 900),
                    ));
                    print(_timeMap[_currentPage]);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Row(
                    children: <Widget>[Icon(Icons.done), Text(" Save")],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 2.0, right: 8.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.redAccent,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Row(
                    children: <Widget>[Icon(Icons.clear), Text(" Cancel")],
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "Hours: ${twoDigits(duration.inHours)}\nMinutes: $twoDigitMinutes";
  }
}
