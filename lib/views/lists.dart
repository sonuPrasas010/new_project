import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yts_movie/controller/lists_controller.dart';
import 'package:yts_movie/views/details.dart';
import 'package:yts_movie/views/yts_model.dart';

import '../models/search_delegate.dart';

class Lists extends StatelessWidget {
  final String title, orderBy, genre;
  late ListsController _listsController;

  Lists(this.title, this.orderBy, this.genre) {
    _listsController = Get.put(ListsController(orderBy, genre));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId:
            "336660035263198_351535040442364", //testid
        bannerSize: BannerSize.STANDARD,
        keepAlive: true,

        listener: (result, value) {
         
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(color: Colors.red),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          color: Colors.red,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(
          () => CustomScrollView(
            controller: _listsController.scrollController,
            slivers: [
              if (_listsController.isLoading.value &&
                  _listsController.page.value == 1)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(
                        () => Details(
                          title: _listsController.movies[index].title,
                          link: _listsController.movies[index].url,
                        ),
                        preventDuplicates: false,
                      );
                    },
                    child: YtsModel(
                      image: _listsController.movies[index].image,
                      name: _listsController.movies[index].title,
                      year: _listsController.movies[index].year,
                      height: 237,
                    ),
                  ),
                  childCount: _listsController.movies.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 263,
                ),
              ),
              if (_listsController.isLoading.value &&
                  _listsController.page.value > 1)
                const SliverToBoxAdapter(child: CupertinoActivityIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
