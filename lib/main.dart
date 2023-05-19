// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:geca/content/showGuideMessege.dart';
// import 'package:geca/dashboard/dashboard.dart';
// import 'package:geca/navigation/myHome.dart';
import 'package:geca/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:package_info/package_info.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'content/landingPage.dart';
import 'checkPost/wrapper.dart';
// import 'content/updateApp.dart';
import 'services/AuthService.dart';
import 'services/myUser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      // ******************
      // code under Start should not included in production
      // debug: true,
      ignoreSsl: true,
      // ******************
      );
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 0, 0, 1),
      statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor: Color.fromRGBO(0, 0, 0, 1),
      // systemNavigationBarIconBrightness: Brightness.light,
      // systemNavigationBarDividerColor: Color.fromRGBO(255, 255, 255, 1),
    ),
  );
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //   ],
  // );
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      initialData: MyUser(),
      value: AuthService().userValidator,
      catchError: (_, err) {
        print('Custom Error : $err');
        return MyUser();
      },
      child: MaterialApp(
        title: 'GECA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}


// -------------

// class TheCore extends StatefulWidget {
//   const TheCore({Key? key}) : super(key: key);

//   @override
//   _TheCoreState createState() => _TheCoreState();
// }

// class _TheCoreState extends State<TheCore> {
//   var showGuideText = false;

//   // For Checking Storage Permission

//   Future<int> checkStoragepermission() async {
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//     // To check whether directory exist or not
//     var dirStatus = await Directory('/storage/emulated/0/Download').exists();
//     print(dirStatus);
//     if (!dirStatus) {
//       await Directory('/storage/emulated/0/Download').create();
//     }
//     return 0;
//   }

//   // For checking and Displaying Update Notification

//   var isUpdateAvailable = false;

//   final FirebaseFirestore _firestore = Fire().getInstance;

//   checkForUpdate() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String currentVersion = packageInfo.version;

//     _firestore
//         .collection('updateApp')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       // ignore: avoid_function_literals_in_foreach_calls
//       querySnapshot.docs.forEach(
//         (doc) {
//           print('======================================== ${doc["version"]}');
//           var updatedVersion = '${doc["version"]}';
//           var notice = '${doc["notice"]}';
//           print(
//               'Its verion 00000000000000000000000000000 $updatedVersion $currentVersion');
//           print('Its notice !!!!!!!!!!!!!!!!!!!!!!!!!!!! $notice');
//           if (updatedVersion != currentVersion) {
//             // pageNumberSelector(1);
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return UpdateApp('${doc["date"]}');
//             }));
//           }
//         },
//       );
//     });
//   }

//   checkWhetherStartScreenToShow() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? currentStatus = prefs.getInt('shouldShowGuideText');
//     if (currentStatus != 1) {
//       setState(() {
//         showGuideText = true;
//       });
//     }
//   }

//   permanentlyCloseShowingGuideText() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //  int counter = (prefs.getInt('counter') ?? 0) + 1;
//     // print('Pressed $counter times.');
//     await prefs.setInt('shouldShowGuideText', 1);
//     setState(() {
//       showGuideText = false;
//     });
//   }

//   temporaryCloseShowingGuideText() {
//     setState(() {
//       showGuideText = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkWhetherStartScreenToShow();
//     checkStoragepermission();
//     checkForUpdate();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return (showGuideText == false)
//     //     ? LandingPage('https://www.ecajmer.ac.in', 'assets/gecaLogo.png')
//     //     : ShowGuideMessege(
//     //         permanentlyCloseShowingGuideText, temporaryCloseShowingGuideText);
//     return MyHome();
//   }
// }
