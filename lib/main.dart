import 'package:flutter/material.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:workout_logger/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<WorkoutUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
