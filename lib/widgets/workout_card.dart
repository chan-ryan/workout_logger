import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;

  WorkoutCard({this.workout});

  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat.MMMMEEEEd().format(widget.workout.start);
    String startToEnd = DateFormat.jm().format(widget.workout.start) +
        " - " +
        DateFormat.jm().format(widget.workout.end);

    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [widget.workout.activity.icon]),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[350])),
                  SizedBox(width: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.workout.activity.activity,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: widget.workout.activity.color)),
                      SizedBox(width: 8.0),
                      Text(startToEnd,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[350]))
                    ],
                  ),
                  /*Text(widget.workout.description,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[350])),*/
                ],
              )
            ],
          ),
        ));
  }
}
