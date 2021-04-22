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
