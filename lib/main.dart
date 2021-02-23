import 'package:flutter/material.dart';
import 'package:workout_logger/widgets/navbar.dart';
import 'package:workout_logger/widgets/workout.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final pages = <Widget>[];

  Workout workoutExample = Workout(
    activity: Activity(
        activity: "Basketball",
        iconData: Icons.sports_basketball_rounded,
        color: Colors.orange),
    date: 'February 21, 2021',
    start: '6:15',
    end: '7:00',
  );

  Widget workoutCard(Workout workout) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              workout.activity.icon,
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(workout.date,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[350])),
                  SizedBox(width: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(workout.activity.activity,
                          style: TextStyle(
                              fontSize: 20.0, color: workout.activity.color)),
                      SizedBox(width: 8.0),
                      Text(workout.start + ' - ' + workout.end,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[350]))
                    ],
                  ),
                  //Text(workout.note)
                ],
              )
            ],
          ),
        ));
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

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
        body: Column(
          children: [workoutCard(workoutExample)],
        ),
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
}
