import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionDenied extends StatelessWidget {
  // final Function pageNumberSelector;
  // StoragePermissionDenied(this.pageNumberSelector);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          // onWillPop: () => pageNumberSelector(),
          onWillPop: () async {
            Navigator.of(context).pop();
            return false;
          },
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Color.fromRGBO(0, 255, 255, 1),
                      child: CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width * 0.2,
                        backgroundColor: Color.fromRGBO(0, 255, 255, 1),
                        foregroundColor: Color.fromRGBO(0, 255, 255, 1),
                        child: Image.asset('assets/fileImage.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
                      child: FittedBox(
                        child: Text(
                          '{{  Storage Permission Denied  }}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontSize: 25,
                            color: Color.fromRGBO(255, 0, 0, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   height: 50,
              //   endIndent: 5,
              //   indent: 5,
              //   thickness: 0.75,
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 110, 0, 0.93),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Allow "GECA" to access STORAGE on your device',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 255, 255, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Step 1  ::  Open Settings\nStep 2  ::  App Permission\nStep 3  ::  Storage\nStep 4  ::  Allow',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                    ),
                    child: Text(
                      'Open Settings',
                      style: TextStyle(
                        fontFamily: 'Signika',
                        fontSize: 20,
                        letterSpacing: 0.75,
                      ),
                    ),
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
