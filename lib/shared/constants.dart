import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.grey[700],
  filled: true,
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0)),
);

Map<String, Activity> activities = {
  "Basketball": Activity(
    activity: "Basketball",
    iconData: Icons.sports_basketball_rounded,
    color: Colors.orange,
  ),
  "Baseball": Activity(
    activity: "Baseball",
    iconData: Icons.sports_baseball_rounded,
    color: Colors.grey[300],
  ),
  "Soccer": Activity(
    activity: "Soccer",
    iconData: Icons.sports_soccer_rounded,
    color: Colors.white,
  ),
  "Football": Activity(
    activity: "Football",
    iconData: Icons.sports_football_rounded,
    color: Colors.orange[900],
  ),
  "Running": Activity(
    activity: "Running",
    iconData: Icons.run_circle_outlined,
    color: Colors.green,
  ),
  "Swimming": Activity(
    activity: "Swimming",
    iconData: null,
    color: Colors.blue,
  ),
  "Weights": Activity(
    activity: "Weights",
    iconData: null,
    color: Colors.red,
  ),
};

Map<int, String> intToMonth = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};

Map<int, String> intToWeekday = {
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday",
};
