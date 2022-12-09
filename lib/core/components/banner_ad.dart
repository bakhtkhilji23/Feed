import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ad_config.dart';
import '../ads/ad_id_provider.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    Key? key,
    this.paddingVertical = 8.0,
  }) : super(key: key);

  final double paddingVertical;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _ad;

  bool isAdLoaded = false;
  bool isInitialized = false;

  void _loadAd() {
    // debugPrint('Initiated Banner Ad Widget');
    _ad = BannerAd(
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // debugPrint('Banner Ad Loaded');
          isInitialized = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError loadAdError) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {
          // debugPrint('$BannerAd onAdOpened.');
        },
        onAdClosed: (Ad ad) {
          ad.dispose();
          // debugPrint('$BannerAd onAdClosed.');
        },
        onAdImpression: (Ad ad) {
          // debugPrint('Ad impression.');
        },
        onAdWillDismissScreen: (ad) {
          ad.dispose();
        },
      ),
      adUnitId: AdIdProvider.bannerID,
      request: const AdRequest(),
    );
    _ad.load();
    isAdLoaded = true;
  }

  @override
  void initState() {
    super.initState();
    if (AdConfig.isAdOn) _loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    // debugPrint('Banner Ad Widget Disposed');
    if (isInitialized && mounted) _ad.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AdConfig.isAdOn == false) {
      return const SizedBox();
    }
    if (isAdLoaded == false) {
      return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: const LinearProgressIndicator(),
      );
    } else if (isAdLoaded) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: widget.paddingVertical),
        child: SizedBox(
          height: 50,
          child: AdWidget(ad: _ad),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
