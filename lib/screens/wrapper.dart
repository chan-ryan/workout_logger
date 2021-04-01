import 'package:flutter/material.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate widget
    return Home();
  }
}
