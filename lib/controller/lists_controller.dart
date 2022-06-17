import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yts_movie/models/InterstitialAd.dart';
import 'package:yts_movie/models/movies.dart';
import 'package:http/http.dart' as http;

class ListsController extends GetxController {
  final String sort_by, genre;
  List<Movies> movies = <Movies>[].obs;

  late ScrollController scrollController;
  RxBool isLoading = true.obs;
  RxInt page = 1.obs;

  ListsController(this.sort_by, this.genre);

  @override
  void onInit() {
    scrollController = ScrollController();
    getMovies();
    super.onInit();

    scrollController.addListener(() {
      if (!isLoading.value &&
          scrollController.position.maxScrollExtent -
                  scrollController.position.pixels <
              250) {
        getMovies();
      }
    });
  }

  Future<void> getMovies() async {
    isLoading(true);
    try {
      var response = await http.get(Uri.parse(
          "https://tormovie.online/apis/torrentList?page=$page&sort_by=$sort_by&genre=$genre"));
      print(
          "https://tormovie.online/apis/torrentList?page=$page&sort_by=$sort_by&genre=$genre");
      var document = await jsonDecode(response.body);
      for (var item in document) {
        movies.add(Movies.fromJson(item));
      }
      page++;
      print(movies);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
