import 'package:flutter/material.dart';

class Activity {
  String activity;
  Icon icon;

  Activity({this.activity, this.icon});
}

class Workout {
  Activity activity;
  String date;
  String start;
  String end;
  String note;

  Workout({this.activity, this.date, this.start, this.end, this.note});
}
