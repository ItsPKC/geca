import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:core';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);
  // For Dashboard
  String get bannerAdUnitId1 => 'ca-app-pub-4788716700673911/4801077299';
  // For Courses
  String get bannerAdUnitId2 => 'ca-app-pub-4788716700673911/8548750619';
  // For Forum
  String get bannerAdUnitId3 => 'ca-app-pub-4788716700673911/1983342268';
  // For Notes & Books
  String get bannerAdUnitId4 => 'ca-app-pub-4788716700673911/8357178928';
  // For College Archives
  String get bannerAdUnitId5 => 'ca-app-pub-4788716700673911/6634949437';
  // That's the list Ads IDs.
  BannerAdListener get adListener => _adListener;
  final BannerAdListener _adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression is recorded for a NativeAd.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

// class GetDeviceSize {
//   static int get myWidth {
//     return ((window.physicalSize.width / window.devicePixelRatio) -
//             (window.physicalSize.width / window.devicePixelRatio) % 20)
//         .truncate();
//   }
// }

getDeviceSize(context) {
  return ((View.of(context).physicalSize.width /
              View.of(context).devicePixelRatio) -
          (View.of(context).physicalSize.width /
                  View.of(context).devicePixelRatio) %
              20)
      .truncate();
}

class Fire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get getInstance {
    return _firestore;
  }
}
