import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geca/content/landingPage.dart';
import 'package:geca/content/newWebView.dart';
import 'package:geca/dashboard/about.dart';
import 'package:geca/dashboard/disclaimer.dart';
import 'package:geca/dashboard/faq.dart';
import 'package:provider/provider.dart';
import 'package:geca/services/ad_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../content/globalVarialbe.dart';

class Dashboard extends StatefulWidget {
  final Function pageNumberSelector;

  Dashboard(this.pageNumberSelector);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _controller = TextEditingController();

  // ----------------------------------------------------
  late BannerAd _banner;
  var isAdsAvailable = false;

  // Ads
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then(
      (status) {
        if (mounted) {
          setState(
            () {
              var w2 = getDeviceSize(context);
              // 80 for default margin and 20 for internal padding
              var h2 = (0.7 * w2).truncate();
              // _banner1 = BannerAd(
              //   adUnitId: adState.bannerAdUnitId1,
              //   size: AdSize.getSmartBanner(Orientation.portrait),
              //   request: AdRequest(),
              //   listener: adState.adListener,
              // )..load();
              // _banner2 = BannerAd(
              //   adUnitId: adState.bannerAdUnitId1,
              //   size: AdSize(
              //     height: h2,
              //     width: w2,
              //   ),
              //   request: AdRequest(),
              //   listener: adState.adListener,
              // )..load();
              _banner = BannerAd(
                adUnitId: adState.bannerAdUnitId1,
                size: AdSize(
                  height: h2,
                  width: w2,
                ),
                request: AdRequest(),
                // listener: adState.adListener,
                listener: BannerAdListener(
                  // Called when an ad is successfully received.
                  onAdLoaded: (Ad ad) {
                    if (isAdsAvailable == false) {
                      setState(() {
                        isAdsAvailable = true;
                      });
                    }
                    print('Ads Loaded');
                  },
                  // Called when an ad request failed.
                  onAdFailedToLoad: (Ad ad, LoadAdError error) {
                    ad.dispose();
                    print('Ad failed to load: $error');
                    // _reloadAds();
                  },
                  // Called when an ad opens an overlay that covers the screen.
                  onAdOpened: (Ad ad) => print('Ad opened.'),
                  // Called when an ad removes an overlay that covers the screen.
                  onAdClosed: (Ad ad) => print('Ad closed.'),
                  // Called when an impression is recorded for a NativeAd.
                  onAdImpression: (ad) => print('Ad impression.'),
                ),
              );
              _banner.load();
            },
          );
        }
      },
    );
  }

  // Future _reloadAds() async {
  //   Timer(
  //     Duration(seconds: 4),
  //     () {
  //       _banner..load();
  //     },
  //   );
  // }

  // Future<void> _makeRequest(url) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult != ConnectivityResult.none) {
  //     try {
  //       if (await canLaunch(url)) {
  //         await launch(
  //           url,
  //           forceWebView: true,
  //           enableJavaScript: true,
  //           enableDomStorage: true,
  //         );
  //       } else {
  //         print('Can\'t lauch now !!!');
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text(
  //                 'GECA',
  //                 style: TextStyle(
  //                   fontFamily: 'Signika',
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 24,
  //                   letterSpacing: 1,
  //                   color: Color.fromRGBO(255, 0, 0, 1),
  //                 ),
  //               ),
  //               content: Text(
  //                 'Failed to connect ...',
  //                 style: TextStyle(
  //                   fontFamily: 'Signika',
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 20,
  //                   letterSpacing: 1,
  //                   color: Color.fromRGBO(36, 14, 123, 1),
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 GestureDetector(
  //                   child: Container(
  //                     width: double.infinity,
  //                     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
  //                     decoration: BoxDecoration(
  //                       color: Color.fromRGBO(255, 0, 0, 1),
  //                       border: Border.all(
  //                         color: Color.fromRGBO(255, 0, 0, 1),
  //                       ),
  //                       borderRadius: BorderRadius.circular(5),
  //                     ),
  //                     child: Text(
  //                       'Close',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         fontFamily: 'Signika',
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 22,
  //                         letterSpacing: 2,
  //                         color: Color.fromRGBO(255, 255, 255, 1),
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           // title: Text('GECA'),
  //           content: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                 child: Icon(
  //                   Icons.network_check,
  //                   size: 32,
  //                   color: Color.fromRGBO(255, 0, 0, 1),
  //                 ),
  //               ),
  //               Text(
  //                 'No Internet',
  //                 style: TextStyle(
  //                   fontFamily: 'Signika',
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 20,
  //                   letterSpacing: 1,
  //                   color: Color.fromRGBO(36, 14, 123, 1),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           actions: <Widget>[
  //             GestureDetector(
  //               child: Container(
  //                 width: double.infinity,
  //                 padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
  //                 decoration: BoxDecoration(
  //                   color: Color.fromRGBO(255, 0, 0, 1),
  //                   border: Border.all(
  //                     color: Color.fromRGBO(255, 0, 0, 1),
  //                   ),
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //                 child: Text(
  //                   'Close',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     fontFamily: 'Signika',
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 22,
  //                     letterSpacing: 2,
  //                     color: Color.fromRGBO(255, 255, 255, 1),
  //                   ),
  //                 ),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> _makeRequestOutSide(url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } else {
          print('Can\'t lauch now !!!');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'GECA',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    letterSpacing: 1,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                content: Text(
                  'Failed to connect ...',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 2,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('GECA'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.network_check,
                    size: 32,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                Text(
                  'No Internet',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    border: Border.all(
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 2,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _makeRequestInside(url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          print('Can\'t lauch now !!!');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'GECA',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    letterSpacing: 1,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                content: Text(
                  'Failed to connect ...',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 2,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('GECA'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.network_check,
                    size: 32,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                Text(
                  'No Internet',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    border: Border.all(
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 2,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    super.deactivate();
  }

  @override
  void dispose() {
    // it is commented to avoid run after dispose
    // _controller.dispose();
    super.dispose();
  }

  myGrid(icon, name, fnc) {
    return GestureDetector(
      onTap: fnc,
      child: Container(
        height: 100,
        // width: MediaQuery.of(context).size.width * 0.5 - 20,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromRGBO(255, 0, 0, 1),
            width: 1,
          ),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0, 1),
          //     blurRadius: 1,
          //     spreadRadius: 1,
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Expanded(
              child: icon,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.circular(3.5),
              ),
              child: FittedBox(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Signika',
                    // fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _backPressed() async {
    _banner.dispose();
    Navigator.of(context).pop();
    return false;
  }

  forceSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Expanded(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   padding: EdgeInsets.all(15),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       TextFormField(
                //         controller: _controller,
                //         decoration: InputDecoration(
                //           labelText: 'Test URL',
                //           hintText: 'https://',
                //         ),
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(top: 15),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             showDialog(
                //               context: context,
                //               builder: (context) => MyWebView(
                //                 widget.pageNumberSelector,
                //                 _controller.text,
                //                 'assets/gecaLogo.png',
                //               ),
                //             );
                //           },
                //           child: Text('Test Now'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Divider(),
                Container(
                  height: MediaQuery.of(context).size.height * 2 / 7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 255, 255, 0.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            // width: (MediaQuery.of(context).size.width - 45) * 0.7,
                            height: 55,
                            decoration: BoxDecoration(
                              // color: Colors.tealAccent,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromRGBO(255, 0, 0, 1),
                                width: 1.25,
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: TextFormField(
                                controller: _controller,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Signika',
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                  hintText: 'Search ?',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Signika',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  // contentPadding: EdgeInsets.fromLTRB(15, 20, 11, 0),
                                  isCollapsed: true,
                                  isDense: false,
                                ),
                                // toolbarOptions: ToolbarOptions(
                                //   copy: true,
                                //   cut: true,
                                //   paste: true,
                                //   selectAll: true,
                                // ),
                                cursorWidth: 2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text(
                                  '${exactMatch ? 'Exact Match, ' : ''}${pdfFilter ? 'pdf, ' : ''}${docFilter ? 'doc, ' : ''}${docxFilter ? 'docx, ' : ''}${pptFilter ? 'ppt, ' : ''}${pptxFilter ? 'pptx, ' : ''}${beforeTime == '' ? '' : '< $beforeTime,'}${afterTime == '' ? '' : '> $afterTime'}')),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: (MediaQuery.of(context).size.width - 45) * 0.3,
                              alignment: Alignment.center,
                              // color: Color.fromRGBO(0, 0, 0, 0.5),
                              margin: EdgeInsets.fromLTRB(15, 0, 7.5, 0),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 0, 0, 1),
                                      width: 1.25,
                                    ),
                                  ),
                                  height: 47,
                                  width:
                                      (MediaQuery.of(context).size.width - 45) *
                                          0.3,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.wifi_protected_setup_rounded,
                                    size: 30,
                                  ),
                                ),
                                onTap: () {
                                  exactMatch = false;
                                  pdfFilter = false;
                                  docFilter = false;
                                  docxFilter = false;
                                  pptFilter = false;
                                  pptxFilter = false;
                                  beforeTime = '';
                                  afterTime = '';
                                  forceSetState();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: (MediaQuery.of(context).size.width - 45) * 0.3,
                              alignment: Alignment.center,
                              // color: Color.fromRGBO(0, 0, 0, 0.5),
                              margin: EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 0, 0, 1),
                                      width: 1.25,
                                    ),
                                  ),
                                  height: 47,
                                  width:
                                      (MediaQuery.of(context).size.width - 45) *
                                          0.3,
                                  alignment: Alignment.center,
                                  // child: Text(
                                  //   'Filter',
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontSize: 20,
                                  //     fontFamily: 'Signika',
                                  //     fontWeight: FontWeight.w700,
                                  //     letterSpacing: 1.5,
                                  //   ),
                                  // ),
                                  child: Icon(
                                    Icons.filter_alt,
                                    size: 30,
                                  ),
                                ),
                                onTap: () {
                                  // if (initialFileType == 'pdf') {
                                  //   setState(() {
                                  //     initialFileType = 'mp4';
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     initialFileType = 'pdf';
                                  //   });
                                  // }
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          color:
                                              Color.fromRGBO(255, 240, 240, 1),
                                          child: Expanded(
                                            child: ListView(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Exact Match',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('exactMatch',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'pdf Filter',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('pdfFilter',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'doc Filter',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('docFilter',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'docx Filter',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('docxFilter',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ppt Filter',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('pptFilter',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'pptx Filter',
                                                      style: TextStyle(
                                                        fontFamily: 'Signika',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    TgButton('pptxFilter',
                                                        forceSetState),
                                                  ],
                                                ),
                                                Divider(),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 20, 0, 20),
                                                  child: Text(
                                                    'Time Based Filter ( Year )',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Signika',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.5,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        // color: Colors.tealAccent,
                                                        margin: EdgeInsets.only(
                                                          top: 10,
                                                          right: 20,
                                                          left: 20,
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 5,
                                                        ),
                                                        child: TextFormField(
                                                          initialValue:
                                                              afterTime,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                          ],
                                                          onChanged: (value) {
                                                            // _dobDD = int.parse(
                                                            //     value);
                                                            // print(_dobDD);
                                                            afterTime = value;
                                                          },
                                                          maxLength: 4,
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Signika',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            letterSpacing: 5,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          cursorColor:
                                                              Colors.red,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            // labelText: "01",
                                                            // hintText: 'DD',
                                                            // helperText: "Pankj",
                                                            counterText:
                                                                'After',
                                                            hintText:
                                                                afterTime == ''
                                                                    ? 'YYYY'
                                                                    : afterTime,
                                                            hintStyle:
                                                                TextStyle(
                                                              letterSpacing: 5,
                                                            ),
                                                            counterStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Signika'),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        // color: Colors.tealAccent,
                                                        margin: EdgeInsets.only(
                                                          top: 10,
                                                          right: 20,
                                                          left: 20,
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 5,
                                                        ),
                                                        child: TextFormField(
                                                          initialValue:
                                                              beforeTime,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                          ],
                                                          onChanged: (value) {
                                                            // _dobDD = int.parse(value);
                                                            // print(_dobDD);
                                                            beforeTime = value;
                                                          },
                                                          maxLength: 4,
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Signika',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            letterSpacing: 5,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          cursorColor:
                                                              Colors.red,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            // labelText: "01",
                                                            // hintText: 'DD',
                                                            // helperText: "Pankj",
                                                            counterText:
                                                                'Before',
                                                            hintText:
                                                                beforeTime == ''
                                                                    ? 'YYYY'
                                                                    : beforeTime,
                                                            hintStyle: TextStyle(
                                                                letterSpacing:
                                                                    5),
                                                            counterStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Signika'),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Divider(),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 20, 0, 20),
                                                    child: Text(
                                                        '** Auto save is active **'))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  height: 38,
                                  // width: MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Search',
                                        style: TextStyle(
                                          fontFamily: 'Signika',
                                          fontSize: 20,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.search_rounded,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ),
                                // onPressed: () async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url',
                                onPressed: () {
                                  if (_controller.text == '') {
                                    return;
                                  }
                                  setState(() {});
                                  var tempText =
                                      'https://cse.google.com/cse?cx=f9a4ff3286056bbb5&q=${_controller.text}';
                                  if (exactMatch == true) {
                                    tempText =
                                        'https://cse.google.com/cse?cx=f9a4ff3286056bbb5&q="${_controller.text}"';
                                  }
                                  if (pdfFilter == true) {
                                    if (tempText.contains('filetype')) {
                                      tempText += ' OR filetype:pdf';
                                    } else {
                                      tempText += ' filetype:pdf';
                                    }
                                  }
                                  if (docFilter == true) {
                                    if (tempText.contains('filetype')) {
                                      tempText += ' OR filetype:doc';
                                    } else {
                                      tempText += ' filetype:doc';
                                    }
                                  }
                                  if (docxFilter == true) {
                                    if (tempText.contains('filetype')) {
                                      tempText += ' OR filetype:docx';
                                    } else {
                                      tempText += ' filetype:docx';
                                    }
                                  }
                                  if (pptFilter == true) {
                                    if (tempText.contains('filetype')) {
                                      tempText += ' OR filetype:ppt';
                                    } else {
                                      tempText += ' filetype:ppt';
                                    }
                                  }
                                  if (pptxFilter == true) {
                                    if (tempText.contains('filetype')) {
                                      tempText += ' OR filetype:pptx';
                                    } else {
                                      tempText += ' filetype:pptx';
                                    }
                                  }
                                  if (beforeTime != '') {
                                    tempText += ' before:$beforeTime';
                                  }
                                  if (afterTime != '') {
                                    tempText += ' after:$afterTime';
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (context) => NewWebView(
                                        widget.pageNumberSelector, tempText),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                  children: [
                    myGrid(
                      Icon(
                        Icons.download_for_offline_rounded,
                        // Icons.cloud_download_rounded,
                        size: MediaQuery.of(context).size.width * 0.095,
                        // color: Color.fromRGBO(36, 14, 123, 1),
                        color: Color.fromRGBO(30, 200, 30, 1),
                        // color: Color.fromRGBO(0, 135, 95, 1),
                      ),
                      'Docs Forum',
                      () {
                        widget.pageNumberSelector(4);
                      },
                    ),

                    myGrid(
                      Icon(
                        Icons.archive_rounded,
                        // Icons.cloud_download_rounded,
                        size: MediaQuery.of(context).size.width * 0.095,
                        color: Color.fromRGBO(36, 14, 123, 1),
                      ),
                      'Articles',
                      () {
                        widget.pageNumberSelector(3);
                      },
                    ),

                    // myGrid(
                    //   Icon(
                    //     Icons.download_for_offline_rounded,
                    //     // Icons.cloud_download_rounded,
                    //     size: MediaQuery.of(context).size.width * 0.095,
                    //     // color: Color.fromRGBO(36, 14, 123, 1),
                    //     color: Color.fromRGBO(30, 200, 30, 1),
                    //     // color: Color.fromRGBO(0, 135, 95, 1),
                    //   ),
                    //   'Archives',
                    //   () {
                    //     widget.pageNumberSelector(5);
                    //   },
                    // ),
                    myGrid(
                      Container(
                        padding: EdgeInsets.fromLTRB(7, 8, 12, 8),
                        child: CircleAvatar(
                          radius: 22,
                          // backgroundImage: AssetImage(
                          //   'assets/reference.png',
                          // ),
                          child: Image.asset(
                            'assets/reference.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      'References',
                      () {
                        widget.pageNumberSelector(6);
                      },
                    ),
                    myGrid(
                      Icon(
                        // Icons.download_for_offline_rounded,
                        Icons.file_download_outlined,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Color.fromRGBO(36, 14, 123, 1),
                      ),
                      'Notes',
                      () {
                        // widget.pageNumberSelector(2);
                        showDialog(
                          context: context,
                          builder: (context) => NewWebView(
                              widget.pageNumberSelector,
                              'https://jecrcfoundation.com/student-corner/notes'),
                        );
                      },
                    ),
                    myGrid(
                      Container(
                        padding: EdgeInsets.fromLTRB(7, 8, 12, 8),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(
                            'assets/NDLLogo.png',
                          ),

                          // child: Image.asset(
                          //   'assets/NDLLogo.png',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      'NDL',
                      () {
                        _makeRequestOutSide('https://ndl.iitkgp.ac.in/');
                      },
                    ),
                    myGrid(
                      Container(
                        padding: EdgeInsets.fromLTRB(7, 8, 12, 8),
                        child: CircleAvatar(
                          radius: 24,
                          // backgroundImage: AssetImage(
                          //   'assets/NDLLogo.png',
                          // ),

                          child: Icon(Icons.star_rounded),
                        ),
                      ),
                      'Student Data',
                      () {
                        _makeRequestInside(
                            'https://ecastudent-developer-edition.ap27.force.com/s');
                      },
                    ),
                  ],
                ),

                // Container(
                //   width: double.infinity,
                //   color: Colors.black,
                //   child: Row(
                //     children: [
                //       GestureDetector(
                //         child: Container(
                //           color: Color.fromRGBO(0, 0, 0, 1),
                //           alignment: Alignment.centerRight,
                //           padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                //           child: Row(
                //             children: [
                //               Icon(
                //                 Icons.info_rounded,
                //                 size: 14,
                //                 color: Colors.white,
                //               ),
                //               SizedBox(
                //                 width: 5,
                //               ),
                //               Text(
                //                 'About',
                //                 style: TextStyle(
                //                   color: Color.fromRGBO(255, 255, 255, 1),
                //                   fontFamily: 'Signika',
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 14,
                //                   letterSpacing: 1.25,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) {
                //               return About();
                //             }),
                //           );
                //         },
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       GestureDetector(
                //         child: Container(
                //           color: Color.fromRGBO(0, 0, 0, 1),
                //           alignment: Alignment.centerRight,
                //           padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                //           child: Row(
                //             children: [
                //               Icon(
                //                 Icons.warning_rounded,
                //                 size: 14,
                //                 color: Color.fromRGBO(255, 255, 255, 1),
                //               ),
                //               SizedBox(
                //                 width: 5,
                //               ),
                //               Text(
                //                 'Disclaimer',
                //                 style: TextStyle(
                //                   color: Color.fromRGBO(255, 255, 255, 1),
                //                   fontFamily: 'Signika',
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 14,
                //                   letterSpacing: 1.25,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) {
                //               return Disclaimer();
                //             }),
                //           );
                //         },
                //       ),
                //       Expanded(
                //         child: Container(
                //           color: Color.fromRGBO(0, 0, 0, 1),
                //           alignment: Alignment.centerRight,
                //           padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                //           child: Text(
                //             'Icy India © 2021',
                //             style: TextStyle(
                //               color: Color.fromRGBO(255, 255, 255, 1),
                //               fontFamily: 'Signika',
                //               fontWeight: FontWeight.w500,
                //               fontSize: 14,
                //               letterSpacing: 1.25,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 0, 0, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 36,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              onPressed: () {
                showModalBottomSheet(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 175,
                        decoration: BoxDecoration(
                          // color: Color.fromRGBO(255, 255, 0, 0.35),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // stops: [0.0, 0.4, 1.0],
                            colors: const [
                              // Initially its color was 0.35
                              // Color.fromRGBO(255, 140, 0, 0.35),
                              // Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(0, 255, 0, 0.35),
                              Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(255, 255, 0, 1),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        25,
                                    margin: EdgeInsets.only(
                                      right: 10,
                                      bottom: 25,
                                    ),
                                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Color.fromRGBO(0, 0, 255, 1),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Feedback',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 255, 1),
                                            fontFamily: 'Signika',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        Icon(
                                          Icons.feedback_rounded,
                                          size: 28,
                                          color: Color.fromRGBO(0, 0, 255, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    // _makeRequest(
                                    //     'https://docs.google.com/forms/d/e/1FAIpQLSc13qRswCTW3hjMb2acCS6L4fjOCT1baGyBtb_exiIYDB26pQ/viewform?usp=sf_link');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LandingPage(
                                            'https://docs.google.com/forms/d/e/1FAIpQLSc13qRswCTW3hjMb2acCS6L4fjOCT1baGyBtb_exiIYDB26pQ/viewform?usp=sf_link',
                                            ''),
                                      ),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        25,
                                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      bottom: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Color.fromRGBO(255, 0, 0, 1),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Report',
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 0, 0, 1),
                                            fontFamily: 'Signika',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        Icon(
                                          Icons.report_problem_rounded,
                                          size: 28,
                                          color: Color.fromRGBO(255, 0, 0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _makeRequestOutSide(
                                        'https://docs.google.com/forms/d/e/1FAIpQLSfPIpo-FQzjaWgXe373JxLXFsFrlsZOIfTfDOt7vKTM960cDw/viewform?usp=sf_link');

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => LandingPage(
                                    //         'https://docs.google.com/forms/d/e/1FAIpQLSfPIpo-FQzjaWgXe373JxLXFsFrlsZOIfTfDOt7vKTM960cDw/viewform?usp=sf_link',
                                    //         ''),
                                    //   ),
                                    // );
                                  },
                                ),
                              ],
                            ),
                            // Divider(),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      backgroundColor:
                                          Color.fromRGBO(255, 0, 0, 1),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.logout_rounded,
                                          size: 28,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      logoutSession(context);
                                    },
                                  ),
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      backgroundColor:
                                          Color.fromRGBO(0, 0, 0, 1),
                                      child: Icon(
                                        Icons.mail_rounded,
                                        size: 30,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    onTap: () {
                                      _makeRequestOutSide(
                                        'mailto:contact@icyindia.com',
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      backgroundColor:
                                          Color.fromRGBO(0, 0, 0, 1),
                                      child: Icon(
                                        Icons.info_rounded,
                                        size: 30,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return About();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      backgroundColor:
                                          // Color.fromRGBO(255, 0, 140, 1),
                                          Color.fromRGBO(0, 0, 0, 1),
                                      child: Icon(
                                        Icons.question_answer_rounded,
                                        size: 30,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Faq();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      backgroundColor:
                                          Color.fromRGBO(0, 0, 0, 1),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0125),
                                        child: Icon(
                                          Icons.warning_rounded,
                                          size: 30,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Disclaimer();
                                          },
                                        ),
                                      );
                                    },
                                  ),

                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius:
                                  //         MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage('assets/koo.png'),
                                  //     backgroundColor: Colors.transparent,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'https://kooapp.com/profile/iampankaj',
                                  //     );
                                  //   },
                                  // ),
                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius: MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage('assets/email.png'),
                                  //     backgroundColor: Colors.transparent,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'mailto:contact@icyindia.com',
                                  //     );
                                  //   },
                                  // ),
                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius: MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage('assets/twitter.jpg'),
                                  //     backgroundColor: Colors.transparent,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'https://twitter.com/IcyIndiaOffice',
                                  //     );
                                  //   },
                                  // ),
                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius: MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage('assets/facebook.jpg'),
                                  //     backgroundColor: Colors.transparent,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'https://facebook.com/icyindia',
                                  //     );
                                  //   },
                                  // ),
                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius: MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage(
                                  //       'assets/linkedin.png',
                                  //     ),
                                  //     backgroundColor: Colors.transparent,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'https://www.linkedin.com/company/icyindia',
                                  //     );
                                  //   },
                                  // ),
                                  // GestureDetector(
                                  //   child: CircleAvatar(
                                  //     radius: MediaQuery.of(context).size.width * 0.06,
                                  //     backgroundImage: AssetImage('assets/whatsapp.png'),
                                  //     backgroundColor: Colors.transparent,
                                  //     // child: Image.asset('assets/whatsapp.jpg'),
                                  //     // child: Icon(Icons.warning_rounded),
                                  //     // child: Icon(Icons.people_alt_rounded),
                                  //     // Icons.privacy_tip_rounded,
                                  //     // Icons.remove_red_eye_rounded,
                                  //   ),
                                  //   onTap: () {
                                  //     _makeRequestOutSide(
                                  //       'whatsapp://send/?phone=910000000000&text=Hii ...  ${String.fromCharCode(0x1F917)} ${String.fromCharCode(0x1F917)} ${String.fromCharCode(0x1F917)}&app_absent=0',
                                  //     );
                                  //   },
                                  // ),

                                  GestureDetector(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      // padding: EdgeInsets.only(
                                      //     bottom:
                                      //         MediaQuery.of(context).size.width * 0.015),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.people_alt_rounded,
                                          size: 30,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            // (0.12 + 0.08)
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2 +
                                                30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [0.1, 1],
                                                colors: const [
                                                  Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  Color.fromRGBO(
                                                      255, 255, 0, 1),
                                                ],
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04,
                                                    0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      // GestureDetector(
                                                      //   child: CircleAvatar(
                                                      //     radius:
                                                      //         MediaQuery.of(context).size.width *
                                                      //             0.06,
                                                      //     backgroundImage:
                                                      //         AssetImage('assets/koo.png'),
                                                      //     backgroundColor: Colors.transparent,
                                                      //   ),
                                                      //   onTap: () {
                                                      //     _makeRequestOutSide(
                                                      //       'https://kooapp.com/profile/iampankaj',
                                                      //     );
                                                      //   },
                                                      // ),
                                                      // GestureDetector(
                                                      //   child: CircleAvatar(
                                                      //     radius:
                                                      //         MediaQuery.of(context).size.width *
                                                      //             0.06,
                                                      //     backgroundImage:
                                                      //         AssetImage('assets/email.png'),
                                                      //     backgroundColor: Colors.transparent,
                                                      //   ),
                                                      //   onTap: () {
                                                      //     _makeRequestOutSide(
                                                      //       'mailto:contact@icyindia.com',
                                                      //     );
                                                      //   },
                                                      // ),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/twitter.jpg'),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                        onTap: () {
                                                          _makeRequestOutSide(
                                                            'https://twitter.com/IcyIndiaOffice',
                                                          );
                                                        },
                                                      ),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/facebook.jpg'),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                        onTap: () {
                                                          _makeRequestOutSide(
                                                            'https://facebook.com/icyindia',
                                                          );
                                                        },
                                                      ),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                          backgroundImage:
                                                              AssetImage(
                                                            'assets/linkedin.png',
                                                          ),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                        onTap: () {
                                                          _makeRequestOutSide(
                                                            'https://www.linkedin.com/company/icyindia',
                                                          );
                                                        },
                                                      ),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/whatsapp.png'),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          // child: Image.asset('assets/whatsapp.jpg'),
                                                          // child: Icon(Icons.warning_rounded),
                                                          // child: Icon(Icons.people_alt_rounded),
                                                          // Icons.privacy_tip_rounded,
                                                          // Icons.remove_red_eye_rounded,
                                                        ),
                                                        onTap: () {
                                                          _makeRequestOutSide(
                                                            'whatsapp://send/?phone=917375873622&text=Hii ...  ${String.fromCharCode(0x1F917)} ${String.fromCharCode(0x1F917)} ${String.fromCharCode(0x1F917)}&app_absent=0',
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 14,
                                                        width: 14,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.35),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                        child: Center(
                                                          child: Image.asset(
                                                            'assets/icon.png',
                                                            height: 7,
                                                            width: 7,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'GECA © 2022',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.35),
                                                          fontFamily: 'Signika',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          letterSpacing: 1.25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

class TgButton extends StatefulWidget {
  final myValue;
  final Function forceSetState;

  TgButton(this.myValue, this.forceSetState, {Key? key}) : super(key: key);

  @override
  State<TgButton> createState() => _TgButtonState();
}

class _TgButtonState extends State<TgButton> {
  @override
  Widget build(BuildContext context) {
    getStatus() {
      var value = false;
      switch (widget.myValue) {
        case 'exactMatch':
          value = exactMatch;
          break;
        case 'pdfFilter':
          value = pdfFilter;
          break;
        case 'docFilter':
          value = docFilter;
          break;
        case 'docxFilter':
          value = docxFilter;
          break;
        case 'pptFilter':
          value = pptFilter;
          break;
        case 'pptxFilter':
          value = pptxFilter;
          break;
      }
      return value;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          switch (widget.myValue) {
            case 'exactMatch':
              exactMatch = !exactMatch;
              break;
            case 'pdfFilter':
              pdfFilter = !pdfFilter;
              break;
            case 'docFilter':
              docFilter = !docFilter;
              break;
            case 'docxFilter':
              docxFilter = !docxFilter;
              break;
            case 'pptFilter':
              pptFilter = !pptFilter;
              break;
            case 'pptxFilter':
              pptxFilter = !pptxFilter;
              break;
          }
        });
        widget.forceSetState();
      },
      child: getStatus()
          ? Icon(
              Icons.toggle_on_rounded,
              size: 60,
              color: Color.fromRGBO(0, 0, 0, 1),
            )
          : Icon(
              Icons.toggle_off_rounded,
              size: 60,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
    );
  }
}
