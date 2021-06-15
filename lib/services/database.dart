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
    /* create subcollection for current month and add a dummy doc/workout
    await userCollection
        .doc(uid)
        .collection(currMonthAndYear)
        .doc('dummy')
        .set({'activity': 'dummy'}); */
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

  void addNewWorkout(Workout workout) async {
    updateMonths(workout.start);
    String monthAndYear = DateFormat.yMMM().format(workout.start);
    String originalDocName = workout.start.toString();
    String docName = originalDocName;
    int count = 1;
    bool exists = await checkExists(docName);
    while (exists) {
      docName = originalDocName + ' (' + count.toString() + ')';
      count += 1;
      exists = await checkExists(docName);
    }
    await userCollection.doc(docName)
        //.collection(monthAndYear)
        //.doc(workout.start.toString())
        .set({
      'date': DateFormat.yMd().format(workout.start),
      'activity': workout.activity,
      'start': workout.start,
      'end': workout.end,
      'description': workout.description
    });
  }

  Future<bool> checkExists(String docName) async {
    try {
      bool exists = false;
      await userCollection.doc(docName).get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  // update months list according to the given DateTime
  void updateMonths(DateTime time) async {
    List<String> months =
        await userCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
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
    userCollection.doc(uid).set({'months': months + newMonths});

    //create new subcollections for added months
    for (String monthAndYear in newMonths) {
      userCollection
          .doc(uid)
          .collection(monthAndYear)
          .doc('dummy')
          .set({'activity': 'dummy'});
    }
  }
}
