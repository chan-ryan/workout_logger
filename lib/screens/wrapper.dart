import 'package:flutter/material.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:workout_logger/screens/home/home_wrapper.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<WorkoutUser>(context);

    //return either Home or Authenticate widget
    return user == null ? Authenticate() : HomeWrapper();
  }
}
