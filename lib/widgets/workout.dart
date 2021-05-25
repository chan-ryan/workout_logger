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

class Workout implements Comparable<Workout> {
  String activity;
  DateTime start;
  DateTime end;
  String description;

  Workout({this.activity, this.start, this.end, this.description});

  // sort by descending order, want latest workouts on top
  int compareTo(Workout other) {
    if (this.start.isAfter(other.start)) {
      return -1;
    } else if (this.start.isBefore(other.start)) {
      return 1;
    } else {
      return 0;
    }
  }
}
