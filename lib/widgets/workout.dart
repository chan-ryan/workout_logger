import 'package:flutter/material.dart';

class Activity {
  String activity;
  IconData iconData;
  Color color;
  Icon icon;

  Activity({this.activity, this.iconData, this.color}) {
    icon = Icon(iconData, color: color, size: 50.0);
  }
}

class Workout {
  Activity activity;
  String date;
  String start;
  String end;
  String description;

  Workout({this.activity, this.date, this.start, this.end, this.description});
}
