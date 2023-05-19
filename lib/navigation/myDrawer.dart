import 'dart:math';
// import '../services/MyAuth.dart';
import 'package:flutter/material.dart';
import 'setting.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final tempBalance = 102.75;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: ListView(
          children: [
            // Start of heading container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      gradient: SweepGradient(
                        colors: const [
                          Color.fromRGBO(255, 0, 0, 1),
                          // Colors.red,
                          Colors.tealAccent,
                          Colors.orange,
                          // Color.fromRGBO(255, 153, 0, 1),
                        ],
                        stops: const [0, 0.35, 1],
                      ),
                    ),
                    child: null,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 7,
                              bottom: 10,
                              left: 7,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              maxRadius:
                                  // (MediaQuery.of(context).size.height * 0.2 - 61- 17)/2,
                                  MediaQuery.of(context).size.height * 0.125 -
                                      39,
                              backgroundImage: NetworkImage(
                                'https://media-exp3.licdn.com/dms/image/C510BAQGCtvCccsWAzw/company-logo_200_200/0/1587130263294?e=2159024400&v=beta&t=q2KZsCM0f5JkYpIvmkCq5zCp8IDistL4rXzarbWID1I',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: const [
                                  Color.fromRGBO(0, 0, 0, 1),
                                  Color.fromRGBO(0, 0, 0, 0.5),
                                  Colors.transparent,
                                ],
                                stops: const [0.25, 0.6, 0.85],
                              ),
                            ),
                            margin: EdgeInsets.only(
                              top: 2,
                              right: 2,
                              bottom: 10,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.settings,
                                size: 26,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              onPressed: () {
                                // Navigator.pop(context);
                                // Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MySetting(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        // margin: EdgeInsets.only(
                        //   right: 7,
                        // ),
                        padding: EdgeInsets.only(
                          top: 3,
                          right: 3,
                          bottom: 4,
                          left: 4,
                        ),
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 28,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Mr. Developer',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Signika',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    // shadows: [
                                    //   Shadow(
                                    //     color: Color.fromRGBO(0, 0, 0, 1),
                                    //     blurRadius: 20,
                                    //   ),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 3,
                              ),
                              child: Text(
                                'contact@icyindia.com',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Signika',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  // shadows: [
                                  //   Shadow(
                                  //     color: Color.fromRGBO(0, 0, 0, 1),
                                  //     blurRadius: 20,
                                  //   ),
                                  // ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // End of Heading Container
            Divider(),
            Container(
              color: Color.fromRGBO(0, 255, 0, 0.075),
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on_sharp,
                          color: Color.fromRGBO(255, 153, 0, 1),
                          size: 48,
                        ),
                        Text(
                          ' $tempBalance',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      size: 32,
                      color: Color.fromRGBO(0, 128, 255, 1),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Accounts',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(0, 255, 0, 0.075),
              trailing: Icon(
                Icons.add_box_rounded,
                size: 32,
                color: Color.fromRGBO(0, 128, 255, 1),
              ),
            ),
            ListTile(
              title: Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Signika',
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(Icons.check_circle_outline_rounded),
              dense: true,
            ),
            ListTile(
              title: Text(
                'Instagram',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Signika',
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(Icons.check_circle_outline_rounded),
              dense: true,
            ),
            ListTile(
              title: Text(
                'Youtube',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Signika',
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(Icons.check_circle_outline_rounded),
              dense: true,
            ),
            ListTile(
              title: Text(
                'Twitter',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Signika',
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(Icons.check_circle_outline_rounded),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text(
                'Facebook Group',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(0, 255, 0, 0.05),
              trailing: Icon(
                Icons.add_box_rounded,
                size: 32,
                color: Color.fromRGBO(0, 128, 255, 1),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Facebook Page',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(0, 255, 0, 0.075),
              trailing: Icon(
                Icons.add_box_rounded,
                size: 32,
                color: Color.fromRGBO(0, 128, 255, 1),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Help Center',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(255, 0, 0, 0.05),
              trailing: Icon(
                Icons.help_center_rounded,
                size: 32,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(255, 0, 0, 0.05),
              trailing: Icon(
                Icons.feedback_rounded,
                size: 32,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'LogOut',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Signika',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tileColor: Color.fromRGBO(255, 0, 0, 0.05),
              trailing: Icon(
                Icons.logout,
                size: 32,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
              onTap: () {
                print(Random().nextDouble());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Alert !!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 0, 0, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Signika',
                          fontSize: 24,
                        ),
                      ),
                      content: Text(
                        'Do you want to logout?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Signika',
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      actions: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                // borderSide: BorderSide(
                                //   width: 1.5,
                                //   color: Color.fromRGBO(255, 0, 0, 1),
                                // ),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Signika',
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              OutlinedButton(
                                // borderSide: BorderSide(
                                //   width: 1.5,
                                //   color: Color.fromRGBO(255, 0, 0, 1),
                                // ),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Signika',
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // AuthService().signOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
