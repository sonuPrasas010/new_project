import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yts_movie/models/movies.dart';

class SearchController extends GetxController {
  List<Movies> movies = <Movies>[].obs;
  var page = 1.obs;
  var isLoading = false.obs;
  late ScrollController scrollController;
  String query = "";

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();

    scrollController.addListener(() {
      if (!isLoading.value &&
          scrollController.position.maxScrollExtent -
                  scrollController.position.pixels <
              250) {
        search(query);
      }
    });
  }

  Future<void> search(String query) async {
    print("scrolled");
    if (query.isEmpty) return;
    this.query = query.trim();
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          "https://tormovie.online/apis/torrentList?search-term=${this.query}&page=$page"));
      var document = await jsonDecode(response.body);
      for (var item in document) {
        movies.add(Movies.fromJson(item));
      }
      page++;
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
