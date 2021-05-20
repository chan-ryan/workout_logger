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
  DateTime start;
  DateTime end;
  String description;

  Workout({this.activity, this.start, this.end, this.description});
}
