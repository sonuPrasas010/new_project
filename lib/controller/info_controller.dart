import 'dart:convert';
import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../models/InterstitialAd.dart';

class InfoController extends GetxController {
  Map info = <String, dynamic>{}.obs;
  RxBool isLoading = true.obs;
  final String url;
  static bool isInterstitialAdLoaded = false;

  InfoController(this.url);
  // BannerAd? bannerAd;
  // var bannerAdIsLoaded = false.obs;

  @override
  void onClose() {
    // bannerAd?.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    // MyInterstitialAd.showAd();
    showInterstitialAd();
    getMovies();
    super.onInit();

    //   bannerAd = BannerAd(
    //       size: AdSize.largeBanner,
    //       adUnitId: Platform.isAndroid
    //           ? 'ca-app-pub-3940256099942544/6300978111'
    //           : 'ca-app-pub-3940256099942544/2934735716',
    //       listener: BannerAdListener(
    //         onAdLoaded: (Ad ad) {
    //           print('$BannerAd loaded.');

    //           bannerAdIsLoaded(true);
    //         },
    //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //           print('$BannerAd failedToLoad: $error');
    //           ad.dispose();
    //         },
    //         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
    //         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
    //       ),
    //       request: AdRequest())
    //     ..load();
  }

  Future<void> getMovies() async {
    isLoading(true);
    try {
      print(url);
      var response = await http.get(Uri.parse(url));
      var document = await jsonDecode(response.body);
      info = document;
    } catch (e) {
      throw e;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refresh() async {
    info.clear();
    getMovies();
  }

  static void loadInterstitialAd() async {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "336660035263198_336911051904763",
      listener: (result, value) {
        print("Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          isInterstitialAdLoaded = true;
        }
        if (result == InterstitialAdResult.ERROR) {
          loadInterstitialAd();
          isInterstitialAdLoaded = false;
        }
        // FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      },
    );
    // print("loading ad");
    // await FacebookInterstitialAd.loadInterstitialAd(
    //   // placementId: "YOUR_PLACEMENT_ID",
    //   placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
    //   listener: (result, value) {
    //     print("listening");
    //     print(">> FAN > Interstitial Ad: $result --> $value");
    //     if (result == InterstitialAdResult.LOADED)
    //       isInterstitialAdLoaded = true;

    //     /// Once an Interstitial Ad has been dismissed and becomes invalidated,
    //     /// load a fresh Ad by calling this function.
    //     if (result == InterstitialAdResult.DISMISSED &&
    //         value["invalidated"] == true) {
    //       isInterstitialAdLoaded = false;
    //       loadInterstitialAd();
    //     }
    //   },
    // );
  }

  static showInterstitialAd() {
    print("showing");
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
      FacebookAudienceNetwork.destroyInterstitialAd().then((value) {
        if (value!) {
          print("destroyed ad");
          isInterstitialAdLoaded = false;
          Future.delayed(
            Duration(minutes: 5),
          ).then(
            (value) => loadInterstitialAd(),
          );
          ;
        }
      });
    } else
      print("Interstial Ad not yet loaded!");
  }
}
