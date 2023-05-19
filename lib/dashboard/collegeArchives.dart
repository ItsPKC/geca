import 'package:flutter/material.dart';
import 'package:geca/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// import 'package:waassist/screen1/openWAredirect.dart';
// import 'package:flutter/services.dart';

class CollegeArchives extends StatefulWidget {
  final Function pageNumberSelector;

  CollegeArchives(this.pageNumberSelector);

  @override
  _CollegeArchivesState createState() => _CollegeArchivesState();
}

class _CollegeArchivesState extends State<CollegeArchives> {
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
              _banner = BannerAd(
                adUnitId: adState.bannerAdUnitId5,
                size: AdSize.fluid,
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

  // End Ads

  myGrid(icon, requestPageNumber) {
    return GestureDetector(
      child: Container(
        height: (MediaQuery.of(context).size.width - 30) * (1 / 3),
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromRGBO(255, 0, 0, 1),
            width: 1.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.maxFinite,
              child: Icon(
                icon,
                size: 36,
              ),
            ),
            Container(
              // alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const [
                    Color.fromRGBO(0, 0, 0, 0),
                    // Color.fromRGBO(0, 0, 0, 0.125),
                    // Color.fromRGBO(0, 0, 0, 0.375),
                    // Color.fromRGBO(0, 0, 0, 0.625),
                    Color.fromRGBO(0, 0, 0, 1),
                  ],
                ),
              ),
              // child: Text(
              //   name,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontFamily: 'Signika',
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: Color.fromRGBO(255, 255, 255, 1),
              //     letterSpacing: 1.5,
              //   ),
              // ),
              child: Center(
                child: Icon(
                  Icons.open_in_new_rounded,
                  size: 34,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // widget.pageNumberSelector(requestPageNumber);
      },
    );
  }

// Future<void> _makeRequest(url) async {
//  var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult != ConnectivityResult.none) {
//       try {
//         if (await canLaunch(url)) {
//           await launch(url);
//         } else {
//           print('Can\'t lauch now !!!');
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text(
//                   'GECA',
//                   style: TextStyle(
//                     fontFamily: 'Signika',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 24,
//                     letterSpacing: 1,
//                     color: Color.fromRGBO(255, 0, 0, 1),
//                   ),
//                 ),
//                 content: Text(
//                   'Failed to connect ...',
//                   style: TextStyle(
//                     fontFamily: 'Signika',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                     letterSpacing: 1,
//                     color: Color.fromRGBO(36, 14, 123, 1),
//                   ),
//                 ),
//                 actions: <Widget>[
//                   GestureDetector(
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       decoration: BoxDecoration(
//                         color: Color.fromRGBO(255, 0, 0, 1),
//                         border: Border.all(
//                           color: Color.fromRGBO(255, 0, 0, 1),
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         'Close',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Signika',
//                           fontWeight: FontWeight.w600,
//                           fontSize: 22,
//                           letterSpacing: 2,
//                           color: Color.fromRGBO(255, 255, 255, 1),
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             // title: Text('GECA'),
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: Icon(
//                     Icons.network_check,
//                     size: 32,
//                     color: Color.fromRGBO(255, 0, 0, 1),
//                   ),
//                 ),
//                 Text(
//                   'No Internet',
//                   style: TextStyle(
//                     fontFamily: 'Signika',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                     letterSpacing: 1,
//                     color: Color.fromRGBO(36, 14, 123, 1),
//                   ),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               GestureDetector(
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(255, 0, 0, 1),
//                     border: Border.all(
//                       color: Color.fromRGBO(255, 0, 0, 1),
//                     ),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Text(
//                     'Close',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Signika',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 22,
//                       letterSpacing: 2,
//                       color: Color.fromRGBO(255, 255, 255, 1),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _banner.dispose();
        return widget.pageNumberSelector(1);
      },
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: ListView(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: const [
                        Color.fromRGBO(255, 140, 0, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                        Color.fromRGBO(0, 255, 0, 0.35),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(255, 0, 0, 1),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Memories',
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          letterSpacing: 1.25,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.add_box_rounded,
                          size: 28,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                myGrid(Icons.document_scanner_rounded, 4),
                myGrid(Icons.image_rounded, 3),
                myGrid(Icons.video_library_rounded, 4),
              ],
            ),
          ),
          // Container(
          //   height: (MediaQuery.of(context).size.height <= 400)
          //       ? 34
          //       : ((MediaQuery.of(context).size.height > 720) ? 92 : 52),
          //   alignment: Alignment.center,
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
        ],
      ),
    );
  }
}
