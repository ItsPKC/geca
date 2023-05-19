import 'package:flutter/material.dart';
import 'package:geca/services/ad_state.dart';
import 'package:permission_handler/permission_handler.dart';
import '../permission/storagePermissionDenied.dart';
import '../services/AuthService.dart';

var myAuthUID = '';
var problemsID = [];

getData() {
  Fire().getInstance.collection('users').doc(myAuthUID).get().then((value) {
    problemsID = value['problemsID'];
  });
}

logoutSession(val) async {
  Navigator.pop(val);
  await AuthService().signOut();
}

// ----------Custom Search ---------------
var exactMatch = false;
var pdfFilter = false;
var docFilter = false;
var docxFilter = false;
var pptFilter = false;
var pptxFilter = false;
var beforeTime = '';
var afterTime = '';
