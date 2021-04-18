import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/widgets/workout.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference workoutsCollection =
      FirebaseFirestore.instance.collection('workoutApp');

  Future updateUserData(
      Map<String, List<Workout>> workouts, List<Activity> activities) async {
    return await workoutsCollection
        .doc(uid)
        .set({'workouts': workouts, 'activities': activities});
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      workouts: snapshot.data()['workouts'],
      activities: snapshot.data()['activites'],
    );
  }

  // get workouts stream
  Stream<QuerySnapshot> get workouts {
    return workoutsCollection.snapshots();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return workoutsCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
