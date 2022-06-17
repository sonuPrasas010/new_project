import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yts_movie/controller/home_controller.dart';
import 'package:yts_movie/views/lists_model.dart';
import 'package:yts_movie/views/yts_model.dart';

class Home extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Yts Movies",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: _homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _homeController.comingSoon.isEmpty
                ? Center(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff9292F8),
                        ),
                        onPressed: () {
                          _homeController.getMovies();
                        },
                        icon: Icon(Icons.refresh_outlined),
                        label: Text("Reload")),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListsModel(
                          // link: "",
                          title: "Featured",
                          subtitle: "For you",
                          movies: _homeController.featured,
                          orderBy: "featured",
                          genre: "all",
                        ),
                        ListsModel(
                          // link: "",
                          title: "Recent",
                          subtitle: "Movies",
                          movies: _homeController.recent,
                          orderBy: "latest",
                          genre: "all",
                        ),
                        ListsModel(
                          // link: "",
                          title: "Top Rated",
                          subtitle: "Movies",
                          movies: _homeController.topRated,
                          orderBy: "rating",
                          genre: "all",
                        ),
                        ListsModel(
                          // link: "",
                          title: "Action",
                          subtitle: "Movies",
                          movies: _homeController.action,
                          orderBy: "latest",
                          genre: "action",
                        ),
                        ListsModel(
                          // link: "",
                          title: "Coming Soon",
                          subtitle: "",
                          movies: _homeController.comingSoon,
                          orderBy: "",
                          genre: "",
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
