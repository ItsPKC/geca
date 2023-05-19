import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:geca/dashboard/requestView.dart';

class MaterialRequestList extends StatefulWidget {
  final target;

  MaterialRequestList(this.target, {Key? key}) : super(key: key);

  @override
  State<MaterialRequestList> createState() => _MaterialRequestListState();
}

class _MaterialRequestListState extends State<MaterialRequestList> {
  final _db = FirebaseFirestore.instance;
  var isDataAvailable = true;
  var _data = [];

  requestData() async {
    var temp;
    if (widget.target == '') {
      temp = _db.collection('forum');
    } else {
      temp = _db.collection('forum').where('branch', isEqualTo: widget.target);
    }
    await temp.get().then((QuerySnapshot qs) {
      for (var element in qs.docs) {
        print('##################################');
        _data.add(element);
        print(element.data());
      }
      setState(() {
        _data = _data;
      });
      if (qs.docs.isEmpty) {
        setState(() {
          isDataAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          child: ListView(
            children: [
              isDataAvailable
                  ? Container()
                  : Container(
                      height: 60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        'No request found in ${widget.target} category',
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
              isDataAvailable && _data.isEmpty
                  ? Container(
                      height: 60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50),
                      child: CupertinoActivityIndicator(),
                    )
                  : Container(),
              ..._data.mapIndexed((index, element) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestView(element),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      // border: Border.all(
                      //   width: 0.25,
                      //   color: Color.fromRGBO(0, 0, 0, 1),
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(0, 0.5),
                          blurRadius: 1.5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "${element["title"]}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Signika',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "${element["discription"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Signika',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(240, 255, 240, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Branch  -  ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Signika',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${element['branch']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Signika',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 240, 240, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Semester  -  ',
                                        style: TextStyle(
                                          // fontSize: 16,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Signika',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${element['semester']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Signika',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                height: 38,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(240, 255, 240, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "${(element["requestID"].toString()).substring(6, 8)} / ${(element["requestID"].toString()).substring(4, 6)} / ${(element["requestID"].toString()).substring(2, 4)}",
                                  style: TextStyle(
                                    // fontSize: 16,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Signika',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
