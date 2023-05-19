import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ad_state.dart';
import 'myUser.dart';

class AuthService {
  var email, pass;
  // AuthService(this.email, this.pass);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _userFromFireBaseUser(user) {
    return (user != null) ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser> get userValidator {
    return _auth.authStateChanges().map((user) => _userFromFireBaseUser(user));
    // .map((user) => _userFromFireBaseUser(user)) can be also be written as
    // .map(_userFromFireBaseUser)
  }

  // To SignIN Anonymously
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      print(result.user!.uid);
      return _userFromFireBaseUser(result.user);
    } catch (e) {
      print('Not Signed Yet');
      return null;
    }
  }

  Future<void> setUserDataTemplate(uid) async {
    await Fire()
        .getInstance
        .collection('users')
        .doc(uid)
        .set({'problemsID': []}, SetOptions(merge: true));
  }

  // SignUp/Register with Email and Password
  Future registerWithEmailandPassword(email, pass) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      setUserDataTemplate(result.user!.uid);
      return _userFromFireBaseUser(result.user);
    } catch (e) {
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      print(e);
    }
  }

  Future logInWithEmailandPassword(email, pass) async {
    try {
      final result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      print(result);
      return _userFromFireBaseUser(result.user);
    } catch (e) {
      print(e.toString());
    }
  }

  // SignOut
  Future signOut() async {
    try {
      print('You are Signed Out');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      print('Error!');
      return null;
    }
  }
}
