import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/widgets/workout_card.dart';
import 'package:workout_logger/widgets/workout_tile.dart';

class CardView extends StatefulWidget {
  final List<Workout> workouts;

  CardView({this.workouts});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    if (widget.workouts.isEmpty) {
      return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text("Nothing yet this month", style: TextStyle(color: Colors.grey[400], fontSize: 20.0))),
      );
    } else {
      widget.workouts.sort();
      return ListView(
        children: widget.workouts
            .map((workout) => WorkoutTile(workout: workout))
            .toList(),
      );
    }
  }
}
