import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_logger/models/user.dart';
import 'package:workout_logger/services/database.dart';
import 'package:workout_logger/shared/constants.dart';
import 'package:workout_logger/widgets/workout.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WorkoutUser _userFromFirebase(User user) {
    return user != null ? WorkoutUser(uid: user.uid) : null;
  }

  Stream<WorkoutUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //sign in anon (not used)
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  //sign in with email and pword
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseService(user.uid).updateMonths(DateTime.now());

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pword
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create new document for user with uid
      await DatabaseService(user.uid).createNewUser();

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
