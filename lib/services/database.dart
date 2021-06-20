import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  String uid;
  CollectionReference userCollection;

  DatabaseService(String uid) {
    this.uid = uid;
    this.userCollection = FirebaseFirestore.instance.collection(this.uid);
  }

  Future createNewUser() async {
    DateTime currTime = DateTime.now();
    String currMonthAndYear = DateFormat.yMMM().format(currTime);
    // create user document and add 'months' field, a list of subcollections
    await userCollection.doc('months').set({
      'months': [currMonthAndYear]
    });
  }

  Stream<Map<String, List<Workout>>> get userWorkouts {
    return userCollection.snapshots().map((QuerySnapshot snapshot) {
      List<Workout> workouts = [];
      dynamic months = [];
      snapshot.docs.forEach((QueryDocumentSnapshot doc) {
        if (doc.data()['months'] != null) {
          months = doc.data()['months'];
        } else {
          workouts.add(Workout(
            activity: doc.data()['activity'],
            start: (doc.data()['start']).toDate(),
            end: (doc.data()['end']).toDate(),
            //description: doc.data()['description']
          ));
        }
      });
      Map<String, List<Workout>> map = {};
      for (String month in months) {
        map[month] = [];
      }
      for (Workout workout in workouts) {
        map[DateFormat.yMMM().format(workout.start)].add(workout);
      }
      return map;
    });
  }

  Future<void> addNewWorkout(Workout workout) async {
    updateMonths(workout.start);
    String docName = workout.start.toString();
    
    await userCollection.doc(docName)
        .set({
      'date': DateFormat.yMd().format(workout.start),
      'activity': workout.activity,
      'start': workout.start,
      'end': workout.end,
      'description': workout.description
    });
  }

  Future<void> updateMonths(DateTime time) async {
    if (time.isAfter(DateTime.now())) {
      await updateFutureMonths(time);
    } else {
      await updatePastMonths(time);
    }
  }

  Future<void> updatePastMonths(DateTime time) async {
    dynamic months =
        await userCollection.doc('months').get().then((DocumentSnapshot snapshot) {
      return snapshot.data()['months'];
    });
    List<String> pastMonths = [];
    DateTime currTime = time;
    while (!months.contains(DateFormat.yMMM().format(currTime))) {
      pastMonths.add(DateFormat.yMMM().format(currTime));
      if (currTime.month == 12) {
        currTime = DateTime(currTime.year + 1, 1);
      } else {
        currTime = DateTime(currTime.year, currTime.month + 1);
      }
    }
    userCollection.doc('months').set({'months': pastMonths + months});
  }

  // update months list according to the given DateTime
  Future<void> updateFutureMonths(DateTime time) async {
    dynamic months =
        await userCollection.doc('months').get().then((DocumentSnapshot snapshot) {
      return snapshot.data()['months'];
    });
    List<String> futureMonths = [];
    DateTime currTime = time;
    while (!months.contains(DateFormat.yMMM().format(currTime))) {
      futureMonths.insert(0, DateFormat.yMMM().format(currTime));
      if (currTime.month == 1) {
        currTime = DateTime(currTime.year - 1, 12);
      } else {
        currTime = DateTime(currTime.year, currTime.month - 1);
      }
    }
    userCollection.doc('months').set({'months': months + futureMonths});
  }
}
