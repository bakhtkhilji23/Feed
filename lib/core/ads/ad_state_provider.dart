import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ad_config.dart';
import 'ad_id_provider.dart';

final loadInterstitalAd =
    FutureProvider.autoDispose<InterstitialAd?>((ref) async {
  InterstitialAd? ad;
  if (AdConfig.isAdOn) {
    await InterstitialAd.load(
      adUnitId: AdIdProvider.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad = ad;
          ad.show();
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (fullad) => fullad.dispose(),
            onAdFailedToShowFullScreenContent: (fullAd, error) =>
                fullAd.dispose(),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint(error.toString());
        },
      ),
    );
  }

  // debugPrint('Inersetial Ad Initiated');

  ref.onDispose(() {
    ad?.dispose();
    // debugPrint('Intersetial Ad disposed');
  });

  return ad;
});
