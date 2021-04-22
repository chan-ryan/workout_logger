import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/widgets/workout.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void updateUserData(
      Map<String, List<Workout>> workouts, List<Activity> activities) async {
    usersCollection
        .doc(uid)
        .collection('042021')
        .doc('dummy')
        .set({'dummy': 'dummy'});
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
  Stream<Map<String, List<Workout>>> get userDoc {
    return usersCollection.doc(uid).snapshots().map(_userWorkoutsFromDoc);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
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

  Future<Map<String, List<Workout>>> _userWorkouts2(
      DocumentSnapshot snapshot) async {
    Map<String, List<Workout>> workoutMap = Map();
    for (String monthYear in snapshot.data()['months']) {
      List<Workout> workoutsInMonth = [];
      QuerySnapshot collectionSnapshot =
          await usersCollection.doc(uid).collection(monthYear).get();
      for (DocumentSnapshot doc in collectionSnapshot.docs) {
        workoutsInMonth.add(Workout(
          activity: activities[doc.data()['activity']],
        ));
      }
      workoutMap[monthYear] = workoutsInMonth;
    }
    return workoutMap;
  }

  Map<String, List<Workout>> _userWorkoutsFromDoc(DocumentSnapshot snapshot) {
    Map<String, List<Workout>> workoutMap = Map();
    for (String monthYear in snapshot.data()['months']) {
      usersCollection
          .doc(uid)
          .collection(monthYear)
          .get()
          .then((QuerySnapshot querysnapshot) {
        workoutMap[monthYear] = workoutListFromSnapshot(querysnapshot);
      });
    }
    return workoutMap;
  }
}
