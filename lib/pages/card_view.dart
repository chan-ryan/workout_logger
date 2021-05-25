import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/widgets/workout_card.dart';

class CardView extends StatefulWidget {
  final List<Workout> workouts;

  CardView({this.workouts});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    List<Workout> sorted = widget.workouts;
    sorted.sort();
    return ListView(
      children: sorted.map((workout) => WorkoutCard(workout: workout)).toList(),
    );
  }
}
