import 'package:flutter/material.dart';

class FailedToLoad extends StatelessWidget {
  final Function _refresh;
  FailedToLoad(this._refresh);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: Icon(
                    Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                    size: 160,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(255, 0, 0, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 0, 0, 1),
                          fontSize: 24,
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      )),
                  onTap: () {
                    _refresh();
                    // To avoid the stack of pages even after page Loaded.
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
