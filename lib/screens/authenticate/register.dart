import 'package:flutter/material.dart';
import 'package:workout_logger/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          title: Text('Register'),
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
                    child: Text("Already have an account? Sign in",
                        style:
                            TextStyle(decoration: TextDecoration.underline))),
                ElevatedButton(
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  child:
                      Text('Register', style: TextStyle(color: Colors.white)),
                ),
              ],
            )));
  }
}
