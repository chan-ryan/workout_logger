import 'package:flutter/material.dart';
import 'package:workout_logger/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[600],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Sign In'),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 0.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text("Don't have an account? Sign up",
                        style:
                            TextStyle(decoration: TextDecoration.underline))),
                ElevatedButton(
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                ),
              ],
            )));
  }
}

/*ElevatedButton(
              child: Text('Sign in anonymously'),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('Error signing in');
                } else {
                  print('Signed in');
                  print(result.uid);
                }
              },
            )*/