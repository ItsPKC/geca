import 'package:geca/dashboard/collegeArchives.dart';
import 'package:geca/dashboard/courses.dart';
import 'package:geca/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geca/dashboard/articles.dart';
import 'package:geca/dashboard/notesAndBooks.dart';
import 'package:geca/dashboard/referenceBank.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

// Ad refresh karne ke liye dispose add karna hai sab me
// @BAND  kare button me

class _MyHomeState extends State<MyHome> {
  var myDrawerKey = GlobalKey<ScaffoldState>();
  var pageNumber = 1;

  void pageNumberSelector(asd) {
    setState(() {
      pageNumber = asd;
    });
  }

  pager(fnc, numb) {
    var pageList = [
      Dashboard(fnc), //1
      Courses(fnc), //2
      Articles(fnc), //3
      NotesAndBooks(fnc), //4
      CollegeArchives(fnc), //5
      ReferenceBank(fnc), //6
    ];
    return pageList[numb];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
        // DeviceOrientation.landscapeRight,
        // DeviceOrientation.landscapeLeft,
      ],
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        resizeToAvoidBottomInset: false,
        // key: myDrawerKey,
        // drawer: MyDrawer(),
        body: Container(
          key: UniqueKey(),
          child: pager(pageNumberSelector, (pageNumber - 1)),
        ),
      ),
    );
  }
}
