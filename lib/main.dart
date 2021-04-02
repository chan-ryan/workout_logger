import 'package:flutter/material.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:workout_logger/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
