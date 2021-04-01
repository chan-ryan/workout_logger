import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/widgets/workout_card.dart';

class CalendarView extends StatefulWidget {
  final List<Workout> workouts;

  CalendarView({this.workouts});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
