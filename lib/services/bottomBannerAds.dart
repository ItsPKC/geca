import 'package:flutter/material.dart';
import 'package:geca/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BottomBannerAds extends StatefulWidget {
  @override
  _BottomBannerAdsState createState() => _BottomBannerAdsState();
}

class _BottomBannerAdsState extends State<BottomBannerAds> {
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
                adUnitId: adState.bannerAdUnitId2,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height <= 400)
          ? 34
          : ((MediaQuery.of(context).size.height > 720) ? 92 : 52),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 0, 1),
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 1),
            width: 2,
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          return (isAdsAvailable == true)
              ? AdWidget(
                  ad: _banner,
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Keep Learning  !!!',
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
