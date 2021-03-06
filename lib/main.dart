import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/navbar.dart';
import 'package:workout_logger/widgets/workout.dart';
import 'package:workout_logger/pages/card_view.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Workout workoutExample = Workout(
  activity: Activity(
      activity: "Basketball",
      iconData: Icons.sports_basketball_rounded,
      color: Colors.orange),
  date: 'February 21, 2021',
  start: '6:15',
  end: '7:00',
  /*description: 'leg day'*/
);

class _HomeState extends State<Home> {
  int index = 0;

  final pages = <Widget>[
    CardView(workouts: [
      workoutExample,
      workoutExample,
      workoutExample,
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
        ),
        backgroundColor: Colors.black,
        body: CardView(workouts: [
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
