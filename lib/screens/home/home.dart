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
                  await signOutConfirmation(context);
                })
          ],
        ),
        backgroundColor: Colors.black,
        body: userWorkouts[DateFormat.yMMM().format(month)] == null ? Loading() : CardView(workouts: userWorkouts[DateFormat.yMMM().format(month)]),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          child: Icon(Icons.add_rounded),
          onPressed: () async {
            await showNewWorkoutForm(context);
          },
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

  Future<void> signOutConfirmation(BuildContext context) async {
    return await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Sign out?'),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
            onPressed: () {Navigator.of(context).pop();},
          ),
          TextButton(
            child: Text('Sign out', style: TextStyle(fontSize: 16.0,)),
            onPressed: () async {
              Navigator.of(context).pop();
              await _auth.signOut();
            },)
        ],
      );
    });
  }

  Future<void> showNewWorkoutForm(BuildContext context) async {
    return await showDialog(context: context, builder: (context) {
      String pickedActivity;
      DateTime pickedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      TimeOfDay start = TimeOfDay.now();
      TimeOfDay end = start;
      String description = '';
      
      return AlertDialog(
        title: Text('Add new workout'),
        content: StatefulBuilder(builder: (context, setState) {
          return Form(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          DropdownButtonFormField(
            //value: pickedActivity ?? 'Pick an activity',
            hint: Text('Pick an activity'),
            items: activities.keys.map((String activity) {
              return DropdownMenuItem(value: activity, child: Text(activity));
            }).toList(),
            onChanged: (val) => setState(() => pickedActivity = val),
          ),
          SizedBox(height: 20.0,),
          Text('Date'),
          TextButton(
            child: Text(
              DateFormat.MMMMEEEEd().format(pickedDate),
            ),
            onPressed: () async {
              DateTime date = await showDatePicker(
                context: context,
                firstDate: DateTime(2021, 6),
                lastDate: DateTime(2021, 12, 31),
                initialDate: pickedDate
              );
              if (date != null) {
                setState(() {
                  pickedDate = date;
                });
              }
            },),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Start time'),
                    TextButton(
                    child: Text(
                      start.format(context),
                    ),
                    onPressed: () async {
                      TimeOfDay selectedStart = await showTimePicker(
                        context: context,
                        initialTime: start
                      );
                      if (selectedStart != null) {
                        setState(() {
                          start = selectedStart;
                        });
                      }
                    },),
                  ]),
                Column(children: [
                Text('End time'),
                TextButton(
                  child: Text(
                    end.format(context),
                  ),
                  onPressed: () async {
                    TimeOfDay selectedEnd = await showTimePicker(
                      context: context,
                      initialTime: end
                    );
                    if (selectedEnd != null) {
                      setState(() {
                        end = selectedEnd;
                      });
                    }
                  },)]),
              ],
            ),
            TextFormField(
              //decoration: textInputDecoration,
              decoration: InputDecoration(hintText: 'Description'),
              onChanged: (val) {
                setState(() => description = val);
              }
            )
        ],));
        },));
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
