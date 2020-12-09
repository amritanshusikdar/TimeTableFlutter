import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:timetable/constants.dart';
import 'package:timetable/utils/marquee.dart';

import '../homescreen/countdown_timer.dart';

class MakeDayPage extends StatefulWidget {
  const MakeDayPage({Key key, this.timeTable, this.title, this.gradientColors})
      : super(key: key);

  final Map<String, Map<TimeOfDay, Duration>> timeTable;
  final String title;
  final List<Color> gradientColors;

  @override
  _MakeDayPageState createState() => _MakeDayPageState();
}

class _MakeDayPageState extends State<MakeDayPage> with AutomaticKeepAliveClientMixin<MakeDayPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);

    List<TimeOfDay> timeStamps = <TimeOfDay>[];
    List<Duration> durations = <Duration>[];
    widget.timeTable.values
        .forEach((innerMap) => innerMap.forEach((timesStamp, duration) {
      timeStamps.add(timesStamp);
    }));

//  SORTING the times in increasing order
    timeStamps.sort((a, b) =>
        (a.hour + a.minute / 60.0).compareTo(b.hour + b.minute / 60.0));

//  ASSIGNING subjects and durations according to the ^^ sorted timeStamps
    List<String> subjects = <String>[];
    for (var arrayTime in timeStamps) {
      widget.timeTable.forEach((subject, timeAndDuration) {
        for (MapEntry e in timeAndDuration.entries) {
          if (arrayTime == e.key) {
            subjects.add(subject);
            durations.add(e.value);
            break;
          }
        }
      });
    }

    int timeTableLength = 0;
    widget.timeTable.values.forEach((value) => timeTableLength += value.length);
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          GradientText(
            widget.title,
            gradient: LinearGradient(colors: [...widget.gradientColors]),
            style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          ),
          ShowCountdownTimer(timeStamps: timeStamps, durations: durations,),
          MakeTimeItemList(
              timeStamps: timeStamps, durations: durations, subjects: subjects, timeTableLength: timeTableLength),
        ],
      ),
    );
  }
}

class MakeTimeItemList extends StatefulWidget {
  const MakeTimeItemList({Key key, @required this.timeStamps, @required this.durations, @required this.subjects, @required this.timeTableLength})
      : super(key: key);

  final List<TimeOfDay> timeStamps;
  final List<Duration> durations;
  final List<String> subjects;
  final int timeTableLength;

  @override
  _MakeTimeItemListState createState() => _MakeTimeItemListState();
}

class _MakeTimeItemListState extends State<MakeTimeItemList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 60.0),
          itemCount: widget.timeTableLength,
          separatorBuilder: (_, index) => Divider(
                color: mOffWhiteColor.withOpacity(0.24),
                thickness: 4.0,
              ),
          itemBuilder: (BuildContext context, int index) {
            String time =
                "${widget.timeStamps[index].hourOfPeriod}:${widget.timeStamps[index].minute.toString().length != 2 ? "0${widget.timeStamps[index].minute}" : widget.timeStamps[index].minute} ${widget.timeStamps[index].hour < 12 ? "AM" : "PM"}";
            return ListTile(
              leading: Icon(
                index % 2 == 0 ? Icons.donut_small : Icons.donut_large,
                color: CupertinoColors.white,
              ),
              title: FittedBox(
                fit: BoxFit.fill,
                child: Container(
                  width: 220.0,
                  child: _marqueeOrNot(widget.subjects[index]),
                ),
              ),
              subtitle: Text(
                "${widget.durations[index].inHours == 0 ? "" : "${widget.durations[index].inHours} hr "}${widget.durations[index].inMinutes.remainder(60) == 0 ? "" : "${widget.durations[index].inMinutes.remainder(60)} min"}",
                style: TextStyle(color: mTextColor, fontSize: 22),
              ),
              trailing: Text(
                time,
                style: TextStyle(color: mTextColor, fontSize: 40.0),
              ),
            );
          }),
    );
  }

  Widget _marqueeOrNot(String subject) {
    if (subject.length > 6) {
      return MarqueeWidget(
        child: Text(
          subject,
          style: TextStyle(color: mTextColor, fontSize: 50.0),
        ),
      );
    } else {
      return Text(
        subject,
        style: TextStyle(color: mTextColor, fontSize: 50.0),
      );
    }
  }
}
