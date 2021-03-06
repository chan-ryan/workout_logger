import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/workout.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;

  WorkoutCard({this.workout});

  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
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
                  Text(widget.workout.date,
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
                      Text(widget.workout.start + ' - ' + widget.workout.end,
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
