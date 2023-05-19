import 'package:flutter/material.dart';
import 'package:geca/dashboard/materialRequestList.dart';
import 'package:geca/dashboard/rsm.dart';
// import 'package:geca/dashboard/asm.dart';
import 'package:geca/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// import 'package:waassist/screen1/openWAredirect.dart';
// import 'package:flutter/services.dart';

class NotesAndBooks extends StatefulWidget {
  final Function pageNumberSelector;

  NotesAndBooks(this.pageNumberSelector);

  @override
  _NotesAndBooksState createState() => _NotesAndBooksState();
}

class _NotesAndBooksState extends State<NotesAndBooks> {
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
                adUnitId: adState.bannerAdUnitId4,
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
                    // It is causing error
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

  myGrid(name, requestPageNumber, target) {
    return GestureDetector(
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.5 - 20,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromRGBO(255, 0, 0, 1),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Icon(
                Icons.note_alt_rounded,
                size: 36,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.circular(3.5),
              ),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Signika',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // widget.pageNumberSelector(requestPageNumber);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialRequestList(target),
            ));
      },
    );
  }

  // Future<void> _makeRequest(url) async {
  //  var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult != ConnectivityResult.none) {
  //     try {
  //       if (await canLaunch(url)) {
  //         await launch(url);
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
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              padding: EdgeInsets.all(15),
              children: [
                myGrid('IT', 8, 'IT'),
                myGrid('CSE', 3, 'CS'),
                myGrid('Civil', 4, 'CE'),
                myGrid('EEE', 7, 'EEE'),
                myGrid('EIC', 6, 'EIC'),
                myGrid('Electrical', 5, 'EE'),
                myGrid('Mechanical', 9, 'ME'),
                myGrid('General For All', 9, 'All'),
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
          //               margin: EdgeInsets.all(10),
          //               child: Text(
          //                 'Keep Learning  !!!',
          //                 style: TextStyle(
          //                   fontFamily: 'Signika',
          //                   fontWeight: FontWeight.w500,E
          //                   fontSize: 24,
          //                 ),
          //               ),
          //             );
          //     },
          //   ),
          // ),
          Container(
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(247, 247, 247, 1),
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  width: 0.25,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(36, 14, 123, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MaterialRequestList(''),
                        ));
                  },
                  child: Icon(Icons.expand),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(36, 14, 123, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RSM(),
                        ));
                  },
                  child: Text(
                    'Request study material',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
