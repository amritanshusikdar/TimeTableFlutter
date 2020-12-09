import 'dart:async';

import 'package:flutter/material.dart';

class ShowCountdownTimer extends StatefulWidget {
  const ShowCountdownTimer({Key key, @required this.timeStamps, @required this.durations}) : super(key: key);
  
  final List<TimeOfDay> timeStamps;
  final List<Duration> durations;
  
  @override
  _ShowCountdownTimerState createState() => _ShowCountdownTimerState();
}

class _ShowCountdownTimerState extends State<ShowCountdownTimer> {
  Timer _timer;
  Duration _current;

  @override
  void initState() {
    super.initState();
    if (widget.durations != null && widget.durations?.length != 0) {
      _current = Duration.zero;
      startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    final totalDurationsLength = widget.durations.length;
    const oneSec = const Duration(seconds: 1);
    int i = 0;

    print(widget.timeStamps);
    print(widget.durations);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
            if (_current == Duration.zero && i < totalDurationsLength) {
              // print("CONDITION BOOLEAN :: --> ${TimeOfDay.now() == widget.timeStamps[i]}");
              // print("NOW:--> ${TimeOfDay.now()}     CONDITION:-->${widget.timeStamps[i]}");
              // print("I --> $i");
              if (TimeOfDay.now() == widget.timeStamps[i]) {
                _current = widget.durations[i];
                i++;
            }
          } else if (i >= totalDurationsLength && _current == Duration.zero) {
              timer.cancel();
            } else {
              _current -= oneSec;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String timerString;
    if (_current == null) {
      timerString = "No items for today!";
    } else {
      int hours = _current.inHours,
          minutes = _current.inMinutes.remainder(60),
          seconds = _current.inSeconds.remainder(60);
      timerString =
          "$hours:${minutes < 10 ? minutes.toString().padLeft(2, "0") : minutes}:${seconds < 10 ? seconds.toString().padLeft(2, "0") : seconds}";
    }

    return Container(
      child: Text(
            timerString,
            style: TextStyle(fontSize: 40.0),
            textAlign: TextAlign.center,
          ),
    );
  }
}
