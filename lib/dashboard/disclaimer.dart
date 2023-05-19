import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                padding: EdgeInsets.all(7),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 0, 0, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Disclaimer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    letterSpacing: 1.25,
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: const [
                      TextSpan(
                        text: '"Reference Bank" ',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 0, 0, 1),
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          letterSpacing: 1.25,
                        ),
                      ),
                      TextSpan(
                        text: 'and',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 1.25,
                        ),
                      ),
                      TextSpan(
                        text: ' "Articles" ',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 0, 0, 1),
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          letterSpacing: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'sections are a conglomeration of freely available, donated, institutionally contributed, or publisher-managed content. Contents in this section are either referenced or accessed from respective sources.\n\nThe responsibility for authenticity, relevance, completeness, accuracy, reliability, and suitability of these contents rests with the respective organization. We have no responsibility or liability for these.\n\nWe are working and every effort made to keep this platform smooth unless there are some unavoidable technical issues.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Signika',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 1.25,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
