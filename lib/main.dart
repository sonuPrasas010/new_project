import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yts_movie/controller/info_controller.dart';
import 'package:yts_movie/models/InterstitialAd.dart';
import 'package:yts_movie/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  // MyInterstitialAd.createInterstitialAd();
  InfoController.loadInterstitialAd();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    
    return GetMaterialApp(
      title: 'Yts Movie Official',
      theme: ThemeData(
        fontFamily: "Giane Gothic",
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}
