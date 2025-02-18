import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_logger/services/auth.dart';
import 'package:workout_logger/shared/loading.dart';
import 'package:workout_logger/widgets/navbar.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/pages/card_view.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final user = Provider.of<WorkoutUser>(context);

    Activity activity = activities[widget.workout.activity];
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
                  children: [activity.icon]),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text(date,
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.grey[350])),
                        SizedBox(width: 94.0),
                        IconButton(icon: Icon(Icons.delete_outline_rounded),
                        onPressed: () async {await deleteWorkoutConfirmation(context, user.uid);})
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(activity.activity,
                          style:
                              TextStyle(fontSize: 20.0, color: activity.color)),
                      SizedBox(width: 8.0),
                      Text(startToEnd,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[350]))
                    ],
                  ),
                  widget.workout.description != '' ? SizedBox(height: 4.0) : SizedBox(),
                  widget.workout.description != '' ? Text(widget.workout.description,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[350])) : SizedBox(),
                ],
              )
            ],
          ),
        ));
  }

  Future<void> deleteWorkoutConfirmation(BuildContext context, String uid) async {
    return await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Delete workout?'),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
            onPressed: () {Navigator.of(context).pop();},
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(fontSize: 16.0,)),
            onPressed: () async {
              Navigator.of(context).pop();
              await DatabaseService(uid).deleteWorkout(widget.workout);
            },)
        ],
      );
    });
  }
}
