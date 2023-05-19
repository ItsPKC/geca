import 'package:flutter/material.dart';
import 'authOptions/emailAndPass.dart';
import 'authOptions/logIn.dart';
import 'authOptions/mobile.dart';

class AuthCenter extends StatefulWidget {
  @override
  _AuthCenterState createState() => _AuthCenterState();
}

class _AuthCenterState extends State<AuthCenter> {
  var pageNumber = 1;
  var pageList = [
    LogIn(),
    EmailAndPass(),
    Mobile(),
    // EmailAndPass(),
    Mobile(),
  ];
  var imageList = [
    'assets/LeatherTexture/L103.jpg',
    'assets/GeneralTexture/image221.jpeg',
    'assets/GeneralTexture/image23.jpg',
    // 'assets/GeneralTexture/image19.jpg',
    // 'assets/GeneralTexture/image2.jpg',
    // 'assets/GeneralTexture/image23.jpg',
    'assets/GeneralTexture/image1.jpg',
    // 'assets/GeneralTexture/image111.jpg',
  ];
  pageNumberSelector(asd) {
    setState(() {
      pageNumber = asd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () => pageNumberSelector(1),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageList[pageNumber - 1]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              pageList[pageNumber - 1],
              (pageNumber == 1)
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   gradient: SweepGradient(
                      //     colors: [
                      //       Colors.red,
                      //       Colors.blue,
                      //       Colors.tealAccent,
                      //     ],
                      //     stops: [0.25, 0.6, 0.8],
                      //   ),
                      // ),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                        child: Text(
                          'Create New Account',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 17,
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            pageNumber = 2;
                          });
                        },
                      ),
                    )
                  : Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // (pageNumber != 4)
                          //     ? Button41(() => pageNumberSelector(4))
                          //     : Button42(),
                          // (pageNumber != 3)
                          //     ? Button31(() => pageNumberSelector(3))
                          //     : Button32(),
                          // (pageNumber != 2)
                          //     ? Button21(() => pageNumberSelector(2))
                          //     : Button22(),
                          // (pageNumber != 1)
                          //     ? Button11(() => pageNumberSelector(1))
                          //     : Button12(),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(50, 50, 50, 0.5),
                                  ),
                                ),
                                onPressed: () {
                                  pageNumberSelector(1);
                                },
                                child: Text(
                                  'I have an account.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontFamily: 'Signika',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.5,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
