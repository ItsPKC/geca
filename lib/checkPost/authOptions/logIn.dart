import 'package:flutter/material.dart';

import '../../services/AuthService.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email, password;
  var progressIndicatorValue = false;
  _logInButtonAction() async {
    print(email);
    print(password);
    setState(() {
      progressIndicatorValue = true;
    });
    var _result =
        await AuthService().logInWithEmailandPassword(email, password);
    if (_result == null) {
      setState(() {
        progressIndicatorValue = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error !!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(255, 0, 0, 1),
                fontWeight: FontWeight.w700,
                fontFamily: 'Signika',
                fontSize: 24,
              ),
            ),
            content: Text(
              'Please use valid credentials.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Signika',
                fontSize: 18,
              ),
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            actions: [
              OutlinedButton(
                // borderSide: BorderSide(
                //   width: 1.5,
                //   color: Color.fromRGBO(255, 0, 0, 1),
                // ),

                child: Text(
                  'Close',
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
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (progressIndicatorValue)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(255, 255, 255, 1)),
            ),
          )
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        // padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'eMail Address',
                            suffixIcon: Icon(
                              Icons.mail_rounded,
                              size: 28,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            // It also override default padding
                            contentPadding: EdgeInsets.only(
                              top: 20,
                              right: 20,
                              bottom: 15,
                              left: 20,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            fontSize: 20,
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: Icon(
                              Icons.lock_rounded,
                              size: 28,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            // It also override default padding
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 20,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 20,
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                          onFieldSubmitted: (_) => _logInButtonAction(),
                        ),
                      ),

                      // LogIn Button
                      GestureDetector(
                        onTap: _logInButtonAction,
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.25,
                          margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            'LogIn',
                            style: TextStyle(
                              fontSize: 24,
                              // fontFamily: 'Signika',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.25,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.black,
                            height: 1.5,
                            width: MediaQuery.of(context).size.width * 0.5 - 45,
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Signika',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black,
                            height: 1.5,
                            width: MediaQuery.of(context).size.width * 0.5 - 45,
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        child: TextButton(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(40),
                          // ),
                          child: Text(
                            'Forget Password ?',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Signika',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              shadows: const [
                                BoxShadow(
                                  color: Colors.brown,
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Unstable network connection, retry after some time.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.5,
                                        height: 1.25,
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
