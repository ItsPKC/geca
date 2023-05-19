import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geca/content/globalVarialbe.dart';
import 'package:geca/permission/storagePermissionDenied.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'content/landingPage.dart';
import 'content/showGuideMessege.dart';
import 'content/updateApp.dart';
import 'services/ad_state.dart';

class TheCore extends StatefulWidget {
  const TheCore({Key? key}) : super(key: key);

  @override
  _TheCoreState createState() => _TheCoreState();
}

class _TheCoreState extends State<TheCore> {
  var showGuideText = false;

  // For Checking Storage Permission

  Future<int> checkStoragepermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var _version = androidInfo.version.sdkInt;
    if (_version < 13) {
      var status = await Permission.storage.status;
      debugPrint(')))))))))))))))))))))${status.isGranted}');
      if (!status.isGranted) {
        Future.delayed(Duration(milliseconds: 500), () async {
          var asd = await Permission.storage.request();
          if (asd == PermissionStatus.permanentlyDenied) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StoragePermissionDenied();
            }));
          }
        });
      }
    } else {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.audio,
        Permission.videos,
        Permission.accessMediaLocation,
        Permission.notification,
      ].request();
    }

    // To check whether directory exist or not
    var dirStatus = await Directory('/storage/emulated/0/Download').exists();
    print(dirStatus);
    if (!dirStatus) {
      await Directory('/storage/emulated/0/Download').create();
    }
    return 0;
  }

  // For checking and Displaying Update Notification

  var isUpdateAvailable = false;

  final FirebaseFirestore _firestore = Fire().getInstance;

  checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    _firestore
        .collection('updateApp')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach(
        (doc) {
          print('======================================== ${doc["version"]}');
          var updatedVersion = '${doc["version"]}';
          var notice = '${doc["notice"]}';
          print(
              'Its verion 00000000000000000000000000000 $updatedVersion $currentVersion');
          print('Its notice !!!!!!!!!!!!!!!!!!!!!!!!!!!! $notice');
          if (updatedVersion != currentVersion) {
            // pageNumberSelector(1);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UpdateApp('${doc["date"]}');
            }));
          }
        },
      );
    });
  }

  checkWhetherStartScreenToShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentStatus = prefs.getInt('shouldShowGuideText');
    if (currentStatus != 1) {
      setState(() {
        showGuideText = true;
      });
    }
  }

  permanentlyCloseShowingGuideText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print('Pressed $counter times.');
    await prefs.setInt('shouldShowGuideText', 1);
    setState(() {
      showGuideText = false;
    });
  }

  temporaryCloseShowingGuideText() {
    setState(() {
      showGuideText = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkWhetherStartScreenToShow();
    checkStoragepermission();
    checkForUpdate();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (showGuideText == false)
        ? LandingPage('https://www.ecajmer.ac.in', 'assets/gecaLogo.png')
        : ShowGuideMessege(
            permanentlyCloseShowingGuideText, temporaryCloseShowingGuideText);
    // return MyHome();
  }
}
