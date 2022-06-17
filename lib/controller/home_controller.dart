import 'dart:convert';

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yts_movie/models/movies.dart';
import 'package:http/http.dart' as http;
import 'package:yts_movie/utitlity.dart';

class HomeController extends GetxController {
  List<Movies> featured = <Movies>[].obs;
  List<Movies> recent = <Movies>[].obs;
  List<Movies> topRated = <Movies>[].obs;
  List<Movies> comingSoon = <Movies>[].obs;
  List<Movies> action = <Movies>[].obs;
  RxBool isLoading = true.obs;


  @override
  void onInit() {
    getMovies();
   
    super.onInit();
  }

  void getMovies() async {
    isLoading(true);
    try {
      var response =
          await http.get(Uri.parse("https://tormovie.online/apis/yts-home"));
      var document = await jsonDecode(response.body);
      for (var item in document['featured']) {
        featured.add(Movies.fromJson(item));
      }
      for (var item in document['recent']) {
        recent.add(Movies.fromJson(item));
      }

      for (var item in document['topRated']) {
        topRated.add(Movies.fromJson(item));
      }
      for (var item in document['comingSoon']) {
        comingSoon.add(Movies.fromJson(item));
      }
      for (var item in document['action']) {
        action.add(Movies.fromJson(item));
      }
      var packageInfo = await PackageInfo.fromPlatform();
      if (document['version'] > int.parse(packageInfo.buildNumber)) {
        Get.defaultDialog(
          title: "Update Available",
          content: const Text(
            "A new update is available. Please update to the latest version.",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                Get.back();
                launchMyUrl(
                  document['url'],
                );
              },
            ),
          ],
        );
      }
    } catch (e) {
      print("I am in catch");
      print(e);
    } finally {
      isLoading(false);
      print(isLoading);
    }
  }
}
