import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void createNewUser() {
    DateTime currTime = DateTime.now();
    String currMonthAndYear = DateFormat.yMMM().format(currTime);
    // create user document and add 'months' field, a list of subcollections
    usersCollection.doc(uid).set({
      'months': [currMonthAndYear]
    });
    // create subcollection for current month and add a dummy doc/workout
    usersCollection
        .doc(uid)
        .collection(currMonthAndYear)
        .doc('dummy')
        .set({'activity': 'dummy'});
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
          start: (doc.data()['start']).toDate(),
          end: (doc.data()['end']).toDate(),
          description: doc.data()['description']);
    }).toList();
  }

  void addNewWorkout(List<String> months, Workout workout) {
    updateMonths(workout.start);
    String monthAndYear = DateFormat.yMMM().format(workout.start);
    usersCollection
        .doc(uid)
        .collection(monthAndYear)
        .doc(workout.start.toString())
        .set({
      'date': DateFormat.yMd().format(workout.start),
      'activity': workout.activity,
      'start': workout.start,
      'end': workout.end,
      'description': workout.description
    });
  }

  // update months list up to the given DateTime
  void updateMonths(DateTime time) async {
    List<String> months =
        await usersCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
      return snapshot.data()['months'];
    });
    List<String> newMonths = [];
    DateTime currTime = time;
    while (!months.contains(DateFormat.yMMM().format(currTime))) {
      newMonths.insert(0, DateFormat.yMMM().format(currTime));
      if (currTime.month == 1) {
        currTime = DateTime(currTime.year - 1, 12);
      } else {
        currTime = DateTime(currTime.year, currTime.month - 1);
      }
    }

    //update months list
    usersCollection.doc(uid).set({'months': months + newMonths});

    //create new subcollections for added months
    for (String monthAndYear in newMonths) {
      usersCollection
          .doc(uid)
          .collection(monthAndYear)
          .doc('dummy')
          .set({'activity': 'dummy'});
    }
  }
}
