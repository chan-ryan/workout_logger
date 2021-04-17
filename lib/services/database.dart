import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/widgets/workout.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference workoutsCollection =
      Firestore.instance.collection('workouts');

  Future updateUserData(String name, Map<String, List<Workout>> workouts,
      List<Activity> activities) async {
    return await workoutsCollection.document(uid).setData(
        {'name': name, 'workouts': workouts, 'activities': activities});
  }

  // get workouts stream
  Stream<QuerySnapshot> get workouts {
    return workoutsCollection.snapshots();
  }
}
