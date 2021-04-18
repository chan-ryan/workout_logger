import 'package:workout_logger/widgets/workout.dart';

class WorkoutUser {
  final String uid;

  WorkoutUser({this.uid});
}

class UserData {
  final String uid;
  final Map<String, List<Workout>> workouts;
  final List<Activity> activities;

  UserData({this.uid, this.workouts, this.activities});
}
