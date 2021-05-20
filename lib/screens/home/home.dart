import 'package:flutter/material.dart';
import 'package:workout_logger/services/auth.dart';
import 'package:workout_logger/widgets/navbar.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/pages/card_view.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_logger/shared/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Workout workoutExample = Workout(
  activity: activities["Basketball"],
  start: DateTime(2021, 5, 20, 6, 15),
  end: DateTime(2021, 5, 20, 8),
  /*description: 'leg day'*/
);

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int index = 0;

  final pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);
    Map<String, List<Workout>> workouts =
        Provider.of<Map<String, List<Workout>>>(context);
    List<String> months = Provider.of<List<String>>(context);

    //int monthIndex = months.length - 1;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {},
              ),
              TextButton(
                child: Text("Month Year",
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {},
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  await _auth.signOut();
                })
          ],
        ),
        backgroundColor: Colors.black,
        body: CardView(workouts: [
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
          workoutExample,
        ]),
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
}
