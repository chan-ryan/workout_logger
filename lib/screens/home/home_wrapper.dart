import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/home/home.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);
    final userData = DatabaseService(uid: user.uid);

    return MultiProvider(
      providers: [
        StreamProvider<Map<String, List<Workout>>>.value(
            value: userData.userWorkoutMap, initialData: null),
        StreamProvider<List<String>>.value(
            value: userData.userMonths, initialData: null)
      ],
      child: Home(),
    );
  }
}
