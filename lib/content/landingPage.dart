import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'collegeWebView.dart';

class LandingPage extends StatefulWidget {
  final String url, logo;
  LandingPage(this.url, this.logo);
  @override
  _LandingPageState createState() => _LandingPageState();
}

// Ad refresh karne ke liye dispose add karna hai sab me
// @BAND  kare button me

class _LandingPageState extends State<LandingPage> {
  //  These 3 lines are used to check the forced crashlytics of application
  // void initState(){
  //   super.initState();
  //   FirebaseCrashlytics.instance.crash();
  // }
  var myDrawerKey = GlobalKey<ScaffoldState>();
  var pageNumber = 1;

  void pageNumberSelector(asd) {
    setState(() {
      pageNumber = asd;
    });
  }

  pager(fnc, numb) {
    var pageList = [
      // MyWebView(fnc, widget.url, widget.logo),
      CollegeWebView(pageNumberSelector, widget.url)
    ];
    return pageList[numb];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
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
