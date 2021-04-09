import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference workoutsCollection =
      Firestore.instance.collection('workouts');

  Future updateUserData(String name, Map workouts, Map activities) async {
    return await workoutsCollection.document(uid).setData(
        {'name': name, 'workouts': workouts, 'activities': activities});
  }
}
