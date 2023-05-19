import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 35),
                padding: EdgeInsets.all(7),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 0, 0, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'About',
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 0, 0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'GECA is an integrated platform for students to provide most of the materials they need during their educational journey in a well-organized way.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color.fromRGBO(36, 14, 123, 1),
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 1.25,
                    height: 1.5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 15),
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(0, 255, 255, 0.25)),
                child: Column(
                  children: const [
                    Text(
                      'What can you get on GECA?',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        fontFamily: 'Signika',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: 1.25,
                      ),
                    ),
                    Text(
                      '\n- Easy access to the official website of Government Engineering College, Ajmer.\n\n- Get stream-wise courses containing well-organized video lectures and supporting materials.\n\n- Access to e-notes and e-Books.\n\n- Access to archives full of documents contributed by volunteers.\n\n- Articles suggested by professionals related to research, innovation, business, etc.\n\n- Easy access to National Digital Library of India.\n\n- Access to Reference Bank full of references to various helpful resources.',
                      textAlign: TextAlign.justify,
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 140, 0, 0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'GECA app is build to save the time of students. It helps to minimize their effort in search of better resources for quality education.\n\nWe hope you\'ll feel better and enjoy using GECA as much as we enjoyed developing it. Looking forward to your participation in creating this platform more reliable for the quality education.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color.fromRGBO(36, 14, 123, 1),
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1.25,
                    height: 1.5,
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
