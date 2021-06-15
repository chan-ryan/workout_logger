import 'package:flutter/material.dart';
import 'package:workout_logger/services/auth.dart';
import 'package:workout_logger/shared/loading.dart';
import 'package:workout_logger/widgets/navbar.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/pages/card_view.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final DateTime month;

  Home({this.month});

  @override
  _HomeState createState() => _HomeState();
}

Workout workoutExample = Workout(
  activity: "Basketball",
  start: DateTime(2021, 4, 20, 6, 15),
  end: DateTime(2021, 4, 20, 8),
  /*description: 'leg day'*/
);

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int index = 0;

  DateTime month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);
    final userWorkouts = Provider.of<Map<String, List<Workout>>>(context);
    print("MAP HERE");
    print(userWorkouts);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                color: Colors.white,
                disabledColor: Colors.grey[600],
                onPressed: !userWorkouts.containsKey(
                      DateFormat.yMMM().format(prevMonth(month))) ? null : () {
                        setState(() {month = prevMonth(month);});
                      },
              ),
              TextButton(
                child: Text(DateFormat.yMMM().format(month),
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                color: Colors.white,
                disabledColor: Colors.grey[600],
                onPressed: !userWorkouts.containsKey(
                      DateFormat.yMMM().format(nextMonth(month))) ? null : () {
                        setState(() {month = nextMonth(month);});
                      },
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app_rounded),
                onPressed: () async {
                  await _auth.signOut();
                })
          ],
        ),
        backgroundColor: Colors.black,
        body: userWorkouts[DateFormat.yMMM().format(month)] == null ? Loading() : CardView(workouts: userWorkouts[DateFormat.yMMM().format(month)]),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          child: Icon(Icons.add_rounded),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBar(
          index: index,
          onChangedTab: onChangedTab,
        ));
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  DateTime nextMonth(DateTime time) {
    if (time.month == 12) {
      return DateTime(time.year + 1, 1);
    } else {
      return DateTime(time.year, time.month + 1);
    }
  }

  DateTime prevMonth(DateTime time) {
    if (time.month == 1) {
      return DateTime(time.year - 1, 12);
    } else {
      return DateTime(time.year, time.month - 1);
    }
  }
}
