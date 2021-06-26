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

class WorkoutTile extends StatelessWidget {
  final Workout workout;

  WorkoutTile({this.workout});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);

    Activity activity = activities[workout.activity];
    String date = DateFormat.MMMMEEEEd().format(workout.start);
    String startToEnd = DateFormat.jm().format(workout.start) +
        " - " +
        DateFormat.jm().format(workout.end);

    return Card(
        margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.grey[850],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: activity.icon,
          title: Text(date, style: TextStyle(fontSize: 16.0, color: Colors.grey[350])),
          subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  workout.description != '' ? SizedBox(height: 4.0) : SizedBox(),
                  workout.description != '' ? Text(workout.description,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[350])) : SizedBox(),
                ],
              ),
          dense: true,
          enableFeedback: true,
          isThreeLine: workout.description != '',
          onLongPress: () async {
            await deleteWorkoutConfirmation(context, user.uid);
          },
        )
      );
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
              await DatabaseService(uid).deleteWorkout(workout);
            },)
        ],
      );
    });
  }

}