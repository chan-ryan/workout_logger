import 'package:flutter/material.dart';
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
        icon: Icon(Icons.sports_basketball_rounded, size: 50.0)),
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
                  Text(workout.date, style: TextStyle(fontSize: 16.0)),
                  SizedBox(width: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(workout.activity.activity,
                          style: TextStyle(fontSize: 20.0)),
                      SizedBox(width: 8.0),
                      Text(workout.start + ' - ' + workout.end,
                          style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                  //Text(workout.note)
                ],
              )
            ],
          ),
        ));
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
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  //list view (default)
                  icon: Icon(Icons.table_rows_rounded),
                  color: index == 0 ? Colors.white : Colors.grey[400],
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                ),
                Opacity(
                  //placeholder
                  opacity: 0,
                  child: IconButton(
                    icon: Icon(Icons.place),
                    onPressed: () {},
                  ),
                ),
                IconButton(
                  //calendar view
                  icon: Icon(Icons.calendar_today_rounded),
                  color: index == 1 ? Colors.white : Colors.grey[400],
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                )
              ],
            )));
  }
}
