import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geca/content/globalVarialbe.dart';

// Request study material

class RSM extends StatefulWidget {
  const RSM({Key? key}) : super(key: key);

  @override
  State<RSM> createState() => _RSMState();
}

class _RSMState extends State<RSM> {
  final _db = FirebaseFirestore.instance;
  var semesterValue = 'All';
  var branchValue = 'All';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  var isUploadingData = false;

  getRequestID() {
    var now = DateTime.now();

    var year = now.year.toString();
    var month = now.month.toString();
    if (int.parse(month) < 10) {
      month = '0$month';
    }
    var day = now.day.toString();
    if (int.parse(day) < 10) {
      day = '0$day';
    }
    var hour = now.hour.toString();
    if (int.parse(hour) < 10) {
      hour = '0$hour';
    }
    var minute = now.minute.toString();
    if (int.parse(minute) < 10) {
      minute = '0$minute';
    }
    var second = now.second.toString();
    if (int.parse(second) < 10) {
      second = '0$second';
    }
    var ms = now.millisecond.toString();
    if (int.parse(ms) < 10) {
      ms = '00$ms';
    } else if (int.parse(ms) < 100) {
      ms = '0$ms';
    }
    return '$year$month$day$hour$minute$second$ms';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Branch',
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Text(
                          'Semester',
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton(
                          alignment: Alignment.center,
                          // Initial Value
                          hint: Text('Branch'),

                          value: branchValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: ([
                            'All',
                            'CE',
                            'EE',
                            'IT',
                            'ME',
                            'CSE',
                            'EEE',
                            'EIC',
                          ]).map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                color: Color.fromRGBO(225, 225, 225, 1),
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    59,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              branchValue = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: DropdownButton(
                          // Initial Value
                          hint: Text('Semester'),

                          value: semesterValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: ([
                            'All',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8'
                          ]).map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              alignment: Alignment.center,
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                  color: Color.fromRGBO(225, 225, 225, 1),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          59,
                                  child: Text(items)),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              semesterValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _controller1,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                maxLength: 80,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Title'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _controller2,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add brief description'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    !isUploadingData
                        ? Color.fromRGBO(230, 0, 0, 1)
                        : Color.fromRGBO(230, 100, 100, 1),
                  ),
                ),
                child: Text(
                  'Submit Request',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
                onPressed: () async {
                  if (isUploadingData == true) {
                    return;
                  }
                  var _requestID = getRequestID();
                  print('=============================');
                  print(_controller1.text != '');
                  print(_controller2.text != '');
                  if (_controller1.text != '' && _controller2.text != '') {
                    print('=============================');
                    setState(() {
                      isUploadingData = true;
                    });
                    var _data = {
                      'requestID': _requestID,
                      'branch': branchValue,
                      'semester': semesterValue,
                      'title': _controller1.text,
                      'discription': _controller2.text,
                    };
                    _db
                        .collection('forum')
                        .doc(_requestID)
                        .set(_data, SetOptions(merge: true))
                        .then((value) {
                      print('------------------------$myAuthUID');
                      _db.collection('users').doc(myAuthUID).set({
                        'problemsID': FieldValue.arrayUnion([_requestID])
                      }, SetOptions(merge: true));
                      problemsID.add(_requestID);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Request submitted successfully.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Signika',
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                          duration: Duration(milliseconds: 2000),
                        ),
                      );

                      Future.delayed(Duration(milliseconds: 500), () {
                        setState(() {
                          isUploadingData = false;
                        });
                        Navigator.of(context).pop();
                      });

                      // var asd = await _db
                      //     .collection("forum")
                      //     .doc("V1Hhd430ClDa6LTlRiOb")
                      //     .collection("response")
                      //     .doc(_responseID)
                      //     .get();
                      // print(asd.data()!["discription"]);
                    }).onError((error, stackTrace) {
                      setState(() {
                        isUploadingData = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Color.fromRGBO(230, 0, 0, 1),
                          content: Text(
                            'Failed to submit request.',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Signika',
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      );
                      print('Error');
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
