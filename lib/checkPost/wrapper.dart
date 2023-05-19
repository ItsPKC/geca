import 'package:flutter/material.dart';
import 'package:geca/theCore.dart';
import 'package:provider/provider.dart';
import '../content/globalVarialbe.dart';
import '../services/myUser.dart';
import 'authCenter.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userValidatorState;
    userValidatorState = Provider.of<MyUser>(context);
    print(userValidatorState);
    print('.............');
    print(userValidatorState.uid);

    if (userValidatorState.uid == null) {
      print('Please LogIn/ SignUp');
    } else {
      myAuthUID = userValidatorState.uid; // In Gobal Variable
    }

    // return (userValidatorState.uid != null)
    // changes to '==' to bypass login screen while development
    return (userValidatorState.uid != null) ? TheCore() : AuthCenter();
  }
}
