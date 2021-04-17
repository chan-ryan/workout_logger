import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.grey[700],
  filled: true,
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0)),
);

List<Activity> stockActivities = [
  Activity(
    activity: "Basketball",
    iconData: Icons.sports_basketball_rounded,
    color: Colors.orange,
  ),
  Activity(
    activity: "Baseball",
    iconData: Icons.sports_baseball_rounded,
    color: Colors.grey[300],
  ),
  Activity(
    activity: "Soccer",
    iconData: Icons.sports_soccer_rounded,
    color: Colors.white,
  ),
  Activity(
    activity: "Football",
    iconData: Icons.sports_football_rounded,
    color: Colors.orange[900],
  ),
  Activity(
    activity: "Running",
    iconData: Icons.run_circle_outlined,
    color: Colors.green,
  ),
  Activity(
    activity: "Swimming",
    iconData: null,
    color: Colors.blue,
  ),
  Activity(
    activity: "Weights",
    iconData: null,
    color: Colors.red,
  ),
];
