import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    question(question) {
      return Container(
        margin: EdgeInsets.fromLTRB(15, 25, 15, 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 255, 0, 0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          question,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Color.fromRGBO(36, 14, 123, 1),
            fontFamily: 'Signika',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      );
    }

    answer(answer) {
      return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: Text(
          answer,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Signika',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.5,
            letterSpacing: 0.75,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: ListView(
          children: [
            question('What is the use of circular Draggable Button?'),
            answer(
              '''
It is a multi-functional draggable button. It can be moved from one place to another as per user choice and remains at the same point until the user does not change or reset the section.

- Single Tap  :  Open DashBoard.

- Double Tap  :  Refresh current page.

- Long Press : 

   🌐  Open current page in Browser.

   🏠  Go to Homepage or Restart.
''',
            ),
            question(
                'Should functionality of "Single Tap" and "Double Tap" reverse.'),
            answer(
              '''
No, the current configuration is designed to prevent state loss due to accidental "Single Tap" while reversing functionality may result in a bad user experience.
            ''',
            ),
          ],
        ),
      ),
    );
  }
}
