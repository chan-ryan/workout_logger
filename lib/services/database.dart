import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/widgets/workout.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void createNewUser() {
    // create user document and add 'months' field, a list of subcollections
    usersCollection.doc(uid).set({
      'months': ['042021']
    });
    // create subcollection for current month and add a dummy doc/workout
    usersCollection
        .doc(uid)
        .collection('042021')
        .doc('dummy')
        .set({'activity': 'dummy'});
  }

  void updateUserData(
      Map<String, List<Workout>> workouts, List<Activity> activities) async {
    usersCollection
        .doc(uid)
        .collection('042021')
        .doc('dummy')
        .set({'activity': 'dummy'});
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      workouts: snapshot.data()['workouts'],
      activities: snapshot.data()['activites'],
    );
  }

  // get map of workouts stream
  Stream<Map<String, List<Workout>>> get userWorkoutMap {
    return usersCollection.doc(uid).snapshots().map(_userWorkoutsFromDoc);
  }

  Stream<List<String>> get userMonths {
    return usersCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return snapshot.data()['months'];
    });
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // return a map (month : list of workouts) from a user doc
  Map<String, List<Workout>> _userWorkoutsFromDoc(DocumentSnapshot snapshot) {
    Map<String, List<Workout>> workoutMap = Map();
    for (String monthYear in snapshot.data()['months']) {
      usersCollection
          .doc(uid)
          .collection(monthYear)
          .where('activity', isNotEqualTo: 'dummy')
          .get()
          .then((QuerySnapshot querysnapshot) {
        workoutMap[monthYear] = workoutListFromSnapshot(querysnapshot);
      });
    }
    return workoutMap;
  }

  // return a list of workout objects from a snapshot (month collection)
  List<Workout> workoutListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Workout(
        activity: doc.data()['activity'],
        date: doc.data()['date'],
      );
    }).toList();
  }
}
