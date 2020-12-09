import 'package:flutter/material.dart';
import 'package:timetable/constants.dart';

Map<int, Map<String, Map<TimeOfDay, Duration>>> _timeMap = {
  sundayConstInt: {},
  mondayConstInt: {
    "PHYSIK": {
      TimeOfDay(hour: 18, minute: 20): Duration(hours: 1, minutes: 0),
      TimeOfDay(hour: 9, minute: 45): Duration(hours: 0, minutes: 30),
    },
    "CHEMIE": {
      TimeOfDay(hour: 22, minute: 12): Duration(hours: 1, minutes: 30),
      TimeOfDay(hour: 7, minute: 30): Duration(hours: 0, minutes: 45),
    },
    "MATHEMATIK": {
      TimeOfDay(hour: 14, minute: 10): Duration(hours: 2, minutes: 30),
      TimeOfDay(hour: 4, minute: 15): Duration(hours: 2, minutes: 15),
    },
  },
  tuesdayConstInt: {
    "MATHEMATIK": {
      TimeOfDay(hour: 14, minute: 10): Duration(hours: 2, minutes: 30),
      TimeOfDay(hour: 4, minute: 15): Duration(hours: 2, minutes: 15),
    },
    "CHEMIE": {
      TimeOfDay(hour: 22, minute: 12): Duration(hours: 1, minutes: 30),
      TimeOfDay(hour: 7, minute: 30): Duration(hours: 0, minutes: 45),
    },
    "PHYSIK": {
      TimeOfDay(hour: 18, minute: 20): Duration(hours: 1, minutes: 0),
      TimeOfDay(hour: 9, minute: 45): Duration(hours: 0, minutes: 30),
    },
  },
  wednesdayConstInt: {
    "PHY": {
      TimeOfDay(hour: 18, minute: 20): Duration(hours: 1, minutes: 0),
      TimeOfDay(hour: 9, minute: 45): Duration(hours: 0, minutes: 30),
    },
  },
  thursdayConstInt: {},
  fridayConstInt: {},
  saturdayConstInt: {},
};
