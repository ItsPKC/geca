import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ASM extends StatefulWidget {
  final element, ri;

  const ASM(this.element, this.ri, {Key? key}) : super(key: key);

  @override
  State<ASM> createState() => _ASMState();
}

class _ASMState extends State<ASM> {
  final _storage = FirebaseStorage.instance;
  final _db = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();
  FilePickerResult? _result;
  File? _file;
  var isUploadingData = false;
  var uploadProgress = 0;

  var semesterValue = 'All';
  var branchValue = 'All';

  getresponseID() {
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
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    offset: Offset(0, 0.5),
                    blurRadius: 1.5,
                  ),
                ],
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
                      "${widget.element["title"]}",
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
                      "${widget.element["discription"]}",
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
                                    letterSpacing: 1,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.element['branch']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Signika',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
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
                            color: Color.fromRGBO(240, 255, 240, 1),
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
                                    letterSpacing: 1,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.element['semester']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Signika',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Solution  :-',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add brief description',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: OutlinedButton(
                onPressed: () async {
                  if (isUploadingData == false) {
                    _result = await FilePicker.platform.pickFiles();

                    if (_result != null) {
                      setState(() {
                        _file = File(_result!.files.single.path!);
                      });
                      print('--------------------------------------');
                      print(_controller.text);
                      print(_file!.path);
                    } else {
                      // User canceled the picker
                    }
                  }
                },
                child: (_file == null) ? Text('Add File') : Text('Change File'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: (_file != null) ? Text(_file!.path) : Container(),
            ),
            // isUploadingData
            //     ? Container(
            //         margin: EdgeInsets.only(
            //           top: 5,
            //           bottom: 5,
            //         ),
            //         child: Slider(
            //           min: 0,
            //           max: 100,
            //           value: uploadProgress,
            //           onChanged: (_) {},
            //         ),
            //       )
            //     : Container(),
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
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
                onPressed: () async {
                  if (isUploadingData == false && _controller.text != '') {
                    setState(() {
                      isUploadingData = true;
                    });
                    var _responseID = getresponseID();
                    var temp = _file != null
                        ? "$_responseID.${_file!.path.split('.').last}"
                        : '';
                    Map<String, dynamic> _data = {
                      'responseID': _responseID,
                      'fileLocation': _file != null ? 'forum/$temp' : '',
                      'discription': _controller.text,
                    };

                    if (_file != null) {
                      final uploadTask =
                          _storage.ref().child('forum/$temp').putFile(_file!);
                      // Listen for state changes, errors, and completion of the upload.
                      uploadTask.snapshotEvents.listen(
                        (TaskSnapshot taskSnapshot) {
                          switch (taskSnapshot.state) {
                            case TaskState.running:
                              final progress = 100.0 *
                                  (taskSnapshot.bytesTransferred /
                                      taskSnapshot.totalBytes);

                              if (progress == 100) {
                                _db
                                    .collection('forum')
                                    .doc('${widget.element['requestID']}')
                                    .collection('response')
                                    .doc(_responseID)
                                    .set(_data, SetOptions(merge: true))
                                    .then((value) {
                                  print('------------------------');

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Response submitted successfully.',
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

                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
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
                                      backgroundColor:
                                          Color.fromRGBO(230, 0, 0, 1),
                                      content: Text(
                                        'Failed to submit respose.',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
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
                              setState(() {
                                setState(() {
                                  uploadProgress = progress.truncate();
                                });
                              });
                              print('Upload is $progress% complete.');
                              break;
                            case TaskState.paused:
                              print('Upload is paused.');
                              break;
                            case TaskState.canceled:
                              print('Upload was canceled');
                              break;
                            case TaskState.error:
                              // Handle unsuccessful uploads
                              break;
                            case TaskState.success:
                              // Handle successful uploads on complete
                              // ...
                              break;
                          }
                        },
                      );
                    } else {
                      _db
                          .collection('forum')
                          .doc(widget.ri)
                          .collection('response')
                          .doc(_responseID)
                          .set(_data, SetOptions(merge: true))
                          .then((value) {
                        print('------------------------');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Response submitted successfully.',
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
                              'Failed to submit respose.',
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
                  }
                  if (_controller.text == '') {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(
                                'Please " Add brief description "',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(230, 0, 0, 1),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Signika',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  }
                },
              ),
            ),
            isUploadingData
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Color.fromRGBO(230, 0, 0, 1),
                        ),
                        Text('$uploadProgress'),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
