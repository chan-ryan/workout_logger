import 'package:flutter/material.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:workout_logger/screens/home/home_wrapper.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);

    //return either Home or Authenticate widget
    return user == null
        ? Authenticate()
        : StreamProvider<Map<String, List<Workout>>>.value(
            value: DatabaseService(user.uid).userWorkouts,
            initialData: null,
            child: Home());
  }
}
