import 'package:flutter/material.dart';
import 'package:workout_logger/services/auth.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/shared/loading.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/widgets/workout.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0.0,
              title: Text('Register'),
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 0.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password of 6 characters or more'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Invalid email';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Text('Register',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text("Already have an account? Sign in",
                                style: TextStyle(
                                    decoration: TextDecoration.underline))),
                        SizedBox(height: 15.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
