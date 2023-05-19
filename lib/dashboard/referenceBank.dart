import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geca/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferenceBank extends StatefulWidget {
  final Function pageNumberSelector;
  ReferenceBank(this.pageNumberSelector);
  @override
  _ReferenceBankState createState() => _ReferenceBankState();
}

class _ReferenceBankState extends State<ReferenceBank> {
  var reloader = [Key('0'), Key('1')];
  // late BannerAd _banner;
  var _details = [];
  // Below 3 var are for efficiently managing ads reloading
  var shouldAdRelload = [];
  var isAdsAvailable = [];
  var adsList = [];
  // Ads
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then(
      (status) {
        // _details.length > 0 is added to avoid loading 1 ads that will never use
        if (mounted && _details.isNotEmpty) {
          print('""""""""""""""""""""""""""""""""""""""""""""""""""');
          setState(
            () {
              // _banner = BannerAd(
              //   adUnitId: adState.bannerAdUnitId3,
              //   size: AdSize.smartBanner,
              //   request: AdRequest(),
              //   // listener: adState.adListener,
              //   listener: BannerAdListener(
              //     // Called when an ad is successfully received.
              //     onAdLoaded: (Ad ad) {
              //       if (isAdsAvailable == false) {
              //         setState(() {
              //           isAdsAvailable = true;
              //         });
              //       }
              //       print('Ads Loaded');
              //     },
              //     // Called when an ad request failed.
              //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
              //       ad.dispose();
              //       print('Ad failed to load: $error');
              //       _reloadAds();
              //     },
              //     // Called when an ad opens an overlay that covers the screen.
              //     onAdOpened: (Ad ad) => print('Ad opened.'),
              //     // Called when an ad removes an overlay that covers the screen.
              //     onAdClosed: (Ad ad) => print('Ad closed.'),
              //     // Called when an impression is recorded for a NativeAd.
              //     onAdImpression: (ad) => print('Ad impression.'),
              //   ),
              // );
              // _banner..load();
              var w2 = getDeviceSize(context) - 20;
              var h2 = (0.7 * w2).truncate();
              for (int i = 0; i < _details.length; i++) {
                isAdsAvailable.insert(i, false);
                shouldAdRelload.insert(i, false);
                if (i % 3 != 0) {
                  adsList.insert(i, '');
                } else {
                  adsList.insert(
                    i,
                    BannerAd(
                      adUnitId: adState.bannerAdUnitId5,
                      size: AdSize(
                        height: h2,
                        width: w2,
                      ),
                      request: AdRequest(),
                      // listener: adState.adListener,
                      listener: BannerAdListener(
                        // Called when an ad is successfully received.
                        onAdLoaded: (Ad ad) {
                          if (isAdsAvailable[i] != true) {
                            setState(() {
                              isAdsAvailable[i] = true;
                            });
                          }
                          print('Ads Loaded');
                        },
                        // Called when an ad request failed.
                        onAdFailedToLoad: (Ad ad, LoadAdError error) {
                          ad.dispose();
                          print('Ad failed to load: $error');
                          // if (isAdsAvailable[i] != true &&
                          //     shouldAdRelload[i] == false) {
                          //   shouldAdRelload[i] = true;
                          //   Timer(
                          //     Duration(seconds: 10),
                          //     () {
                          //       _reloadAds(adsList[i], i);
                          //       shouldAdRelload[i] = false;
                          //     },
                          //   );
                          // }
                        },
                        // Called when an ad opens an overlay that covers the screen.
                        onAdOpened: (Ad ad) => print('Ad opened.'),
                        // Called when an ad removes an overlay that covers the screen.
                        onAdClosed: (Ad ad) => print('Ad closed.'),
                        // Called when an impression is recorded for a NativeAd.
                        onAdImpression: (ad) => print('Ad impression.'),
                      ),
                    )..load(),
                  );
                }
              }
            },
          );
        }
      },
    );
  }

  // Future _reloadAds(ad, i) async {
  //   print(
  //       '$i...##################################################################');
  //   ad..load();
  // }

  // End Ads

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  getImageAddress(url) async {
    print('ccccccccccccccccccccccccccccccccccccccccc$url');
    var temp = await _firebaseStorage
        .refFromURL('gs://gecaapp.appspot.com/F1/$url')
        .getDownloadURL();
    return temp;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _getContentReference() async {
    await _firestore.collection('reference').get().then(
      (QuerySnapshot querySnapshot) {
        setState(() {
          _details = querySnapshot.docs;
        });
        print('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQqqqqqqqqqqqqqq');
      },
    );
    didChangeDependencies();
    print('WWWWWWWWWWWWWWW');
    return true;
  }

  _makeRequest(url) async {
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

  myGrid(image, url1, url2) {
    return Container(
      key: reloader[0],
      margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              // 30 + 4px border
              // height: (MediaQuery.of(context).size.width - 34) * 9 / 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return CachedNetworkImage(
                      imageUrl: '${snapshot.data}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/not_found.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                    // child: Text(
                    //   '...',
                    //   style: TextStyle(
                    //     fontSize: 36,
                    //   ),
                    // ),
                  );
                },
                future: getImageAddress(image),
              ),
            ),
          ),
          Container(
            height: 60,
            // color: Color.fromRGBO(5, 255, 176, 1),
            color: Color.fromRGBO(0, 0, 0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (url1 != '' && url1 != null)
                    ? GestureDetector(
                        child: Icon(
                          Icons.send_to_mobile,
                          size: 34,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        onTap: () {
                          _makeRequest(url1);
                        },
                      )
                    : Container(),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: 2,
                  // to make visible only when both field are available
                  color:
                      (url1 != '' && url2 != '' && url1 != null && url2 != null)
                          ? Color.fromRGBO(255, 255, 255, 0.5)
                          : Colors.transparent,
                ),
                (url2 != '' && url2 != null)
                    ? GestureDetector(
                        child: Icon(
                          // Icons.local_fire_department_sharp,
                          Icons.open_in_browser_rounded,
                          size: 34,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        onTap: () {
                          _makeRequest(url2);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _getContentReference();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // _banner.dispose();
        for (int i = 0; i < _details.length; i += 3) {
          adsList[i].dispose();
        }
        return widget.pageNumberSelector(1);
      },
      // child: Column(
      child: RefreshIndicator(
        onRefresh: () async {
          // This method is used to save ads to distroy
          var temp = reloader[0];
          reloader[0] = reloader[1];
          reloader[1] = temp;
          print("''''''''''''''''''''${reloader[0]}");
          setState(() {});
        },
        child: (_details.isNotEmpty)
            ? ListView(
                children: [
                  // Expanded(
                  //   child: ListView.separated(
                  //     itemCount: _details.length,
                  //     itemBuilder: (context, index) {
                  //       return myGrid(
                  //         _details[index]["PreviewImage"],
                  //         _details[index]["AndroidAppUrl"],
                  //         _details[index]["WebsiteUrl"],
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) {
                  //       return (index % 2 == 0)
                  //           ? Container(
                  //               height: 0.7 * (GetDeviceSize.myWidth - 20).truncate(),
                  //               margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
                  //               color: Colors.tealAccent,
                  //               child: (adsList.length != 0 &&
                  //                       adsList[index] != 'adsFailedtoLoad')
                  //                   ? AdWidget(
                  //                       ad: adsList[index],
                  //                     )
                  //                   : Container(
                  //                       child: Center(
                  //                         child: Text('Keep Learning ...'),
                  //                       ),
                  //                     ),
                  //             )
                  //           : Container();
                  //     },
                  //   ),
                  // ),
                  ..._details.map(
                    (element) {
                      var temp = _details.indexOf(element);
                      if (temp % 3 == 0) {
                        return Column(
                          children: [
                            Container(
                              height: 0.7 *
                                  (getDeviceSize(context) - 20).truncate(),
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              color: Colors.tealAccent,
                              child: (isAdsAvailable[temp] == true)
                                  ? Builder(
                                      builder: (context) {
                                        return AdWidget(
                                          ad: adsList[temp],
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text('Keep Learning ...'),
                                    ),
                            ),
                            myGrid(
                              element['PreviewImage'],
                              element['AndroidAppUrl'],
                              element['WebsiteUrl'],
                            ),
                          ],
                        );
                      }
                      return myGrid(
                        element['PreviewImage'],
                        element['AndroidAppUrl'],
                        element['WebsiteUrl'],
                      );
                    },
                  )
                ],
              )
            : Center(
                child: Text(
                  'Connecting ...',
                  style: TextStyle(
                    color: Color.fromRGBO(55, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

// Container(
//   height: (MediaQuery.of(context).size.height <= 400)
//       ? 34
//       : ((MediaQuery.of(context).size.height > 720) ? 92 : 52),
//   decoration: BoxDecoration(
//     color: Color.fromRGBO(255, 255, 0, 1),
//     border: Border(
//       top: BorderSide(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         width: 2,
//       ),
//     ),
//   ),
//   child: Builder(
//     builder: (context) {
//       return (isAdsAvailable == true)
//           ? AdWidget(
//               ad: _banner,
//             )
//           : Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.all(10),
//               child: Text(
//                 'Keep Learning  !!!',
//                 style: TextStyle(
//                   fontFamily: 'Signika',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 24,
//                 ),
//               ),
//             );
//     },
//   ),
// ),

//  Center(
//   child: Text(
//     "Connecting ...",
//     style: TextStyle(
//       color: Color.fromRGBO(55, 0, 0, 1),
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//     ),
//   ),
// );
