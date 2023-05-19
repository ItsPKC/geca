import 'package:flutter/material.dart';

class ShowGuideMessege extends StatefulWidget {
  final Function permanentCloser, temporaryCloser;
  ShowGuideMessege(this.permanentCloser, this.temporaryCloser);

  @override
  _ShowGuideMessegeState createState() => _ShowGuideMessegeState();
}

class _ShowGuideMessegeState extends State<ShowGuideMessege> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      'Do you know ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Signika',
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 25),
                    child: Text(
                      '''
A multi-functional DRAGGABLE button can\nMove & Place as per user choice ...

- Single Tap  :  Open DashBoard.

- Double Tap  :  Refresh current page.

- Long Press : 

   🌐  Open current page in Browser.

   🏠  Go to Homepage or Restart.
''',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Signika',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Text(
                      '▢ Don\'t show again.',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontFamily: 'Signika',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  onPanStart: (details) {
                    widget.permanentCloser();
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontFamily: 'Signika',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5),
                    ),
                  ),
                  onPanStart: (details) {
                    widget.temporaryCloser();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
