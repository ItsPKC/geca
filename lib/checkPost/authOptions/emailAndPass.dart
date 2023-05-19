import 'package:flutter/material.dart';

import '../../services/AuthService.dart';

class EmailAndPass extends StatefulWidget {
  const EmailAndPass({Key? key}) : super(key: key);

  @override
  _EmailAndPassState createState() => _EmailAndPassState();
}

class _EmailAndPassState extends State<EmailAndPass> {
  var email, password;
  var progressIndicatorValue = false;
  // _signUpActionButton() async {
  //   print(email);
  //   print(password);
  //   setState(() {
  //     progressIndicatorValue = true;
  //   });
  //   var _result =
  //       await AuthService().registerWithEmailandPassword(email, password);
  //   if (_result == null) {
  //     setState(() {
  //       progressIndicatorValue = true;
  //     });
  //   }
  // }

  _signUpActionButton() async {
    print(email);
    print(password);
    setState(() {
      progressIndicatorValue = true;
    });
    var _result =
        await AuthService().registerWithEmailandPassword(email, password);
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
              backgroundColor: Colors.tealAccent,
              value: 10,
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
                          bottom: 10,
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
                          onFieldSubmitted: (_) => _signUpActionButton(),
                        ),
                      ),
                      // SignUp Button

                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.25,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 60),
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
                            'SignUp',
                            style: TextStyle(
                              fontSize: 24,
                              // fontFamily: 'Signika',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.25,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                          ),
                        ),
                        onTap: () => _signUpActionButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
