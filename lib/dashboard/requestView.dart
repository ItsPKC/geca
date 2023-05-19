import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:geca/content/globalVarialbe.dart';
import 'package:geca/dashboard/asm.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:geca/services/ad_state.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../permission/storagePermissionDenied.dart';

class RequestView extends StatefulWidget {
  final element;

  const RequestView(this.element, {Key? key}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  final _db = FirebaseFirestore.instance;
  var element;
  var _data = [];

  getSoultion() async {
    await _db
        .collection('forum')
        .doc(element['requestID'])
        .collection('response')
        .get()
        .then((QuerySnapshot qs) {
      for (var element in qs.docs) {
        print('##################################');
        _data.add(element);
        print(element.data());
      }
      setState(() {
        _data = _data;
      });
    });
  }

  Future getDownloadLink(profileLocation) async {
    // var resizedImage = profileLocation;
    // List<String> temp = resizedImage.split('.');
    // temp.insert(temp.length - 1, '_100x100.');
    // temp.join();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 750),
        content: Text(
          'Please Wait !!!',
        ),
      ),
    );
    var _downloadUrl =
        await FirebaseStorage.instance.ref(profileLocation).getDownloadURL();

    downloader(_downloadUrl);
  }

  // ----------------
  Future downloader(url) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text(
          'Starting Download !!!',
        ),
      ),
    );

    // var baseExtDirectory = await getExternalStorageDirectory();
    await FlutterDownloader.enqueue(
      url: url,
      // savedDir: baseExtDirectory!.path,
      savedDir: '/storage/emulated/0/Download',
      // Such date formate is used to simplify downloads
      fileName:
          "Mr.PKC-${DateFormat('yyyyMMdd').format(DateTime.now())}${DateTime.now()}.mp4",
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true,
      // click on notification to open downloaded file (for Android)
      saveInPublicStorage: true,
    );
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    // -------------------------
    element = widget.element;
    getSoultion();
    // -------------------------
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      // String id = data[0];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print('Download Completed');
      }
      // setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  // ----------------

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
                borderRadius: BorderRadius.circular(5),
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
                                  // text: '8',
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
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (problemsID.contains(element['requestID']))
                      ? ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(230, 0, 0, 1)),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Are you sure to delete this problem.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Signika',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                              fontFamily: 'Signika',
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(230, 0, 0, 1)),
                                        ),
                                      ),
                                      OutlinedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromRGBO(
                                                          230, 0, 0, 1))),
                                          onPressed: () {
                                            Fire()
                                                .getInstance
                                                .collection('forum')
                                                .doc(element['requestID'])
                                                .delete();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontFamily: 'Signika',
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                          )),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  );
                                });
                          },
                          child: Icon(Icons.delete_forever_rounded),
                        )
                      : Container(),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(230, 0, 0, 1))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ASM(element, element['requestID']),
                        ),
                      );
                    },
                    child: Text(
                      'Add Solution',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Signika',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: (problemsID.contains(element['requestID']))
                  ? EdgeInsets.fromLTRB(8, 10, 8, 10)
                  : EdgeInsets.fromLTRB(8, 0, 8, 10),
              child: Text(
                'Available Solution :-',
                style: TextStyle(
                  fontFamily: 'Siginika',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            ..._data.mapIndexed((index, element) {
              return Container(
                margin: EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 47,
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 255, 245, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${(element["responseID"].toString()).substring(6, 8)} / ${(element["responseID"].toString()).substring(4, 6)} / ${(element["responseID"].toString()).substring(2, 4)}",
                            style: TextStyle(
                              // fontSize: 16,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Signika',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          (element['fileLocation']).length > 0
                              ? OutlinedButton(
                                  onPressed: () {
                                    getDownloadLink(element['fileLocation']);
                                  },
                                  child: Text('Get Resources'))
                              : Container(),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
