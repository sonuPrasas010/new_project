import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yts_movie/controller/search_controller.dart';

import '../views/details.dart';
import '../views/yts_model.dart';

class Search extends SearchDelegate {
  final SearchController _searchController = Get.put(SearchController());
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    _searchController.page(1);
    print(_searchController.page.value);
    _searchController.movies.clear();
    _searchController.search(query);

    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          controller: _searchController.scrollController,
          slivers: [
            if (_searchController.isLoading.value &&
                _searchController.page.value == 1)
              const SliverFillRemaining(
                hasScrollBody: false,
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
                              title: _searchController.movies[index].title,
                              link: _searchController.movies[index].url,
                            ),
                        preventDuplicates: false);
                  },
                  child: YtsModel(
                    image: _searchController.movies[index].image,
                    name: _searchController.movies[index].title,
                    year: _searchController.movies[index].year,
                    height: 237,
                  ),
                ),
                childCount: _searchController.movies.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                mainAxisExtent: 263,
              ),
            ),
            if (_searchController.page.value > 1 &&
                _searchController.isLoading.value)
              const SliverToBoxAdapter(child: CupertinoActivityIndicator())
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("suggestions");
  }
}
