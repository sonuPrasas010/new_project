import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yts_movie/models/movies.dart';
import 'package:yts_movie/views/details.dart';
import 'package:yts_movie/views/lists.dart';

import 'yts_model.dart';

class ListsModel extends StatelessWidget {
  final String title, subtitle, orderBy, genre;
  final List<Movies> movies;

  ListsModel(
      {required this.title,
      required this.subtitle,
      // required this.link,
      required this.movies,
      required this.orderBy,
      required this.genre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: " $subtitle",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => Lists(title, orderBy, genre));
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Color(0xff9292F8),
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 176,
            child: ListView.separated(
              itemCount: movies.length,
              separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  Get.to(
                    () => Details(
                      title: movies[index].title.toString(),
                      link: movies[index].url.toString(),
                    ),
                    preventDuplicates: false,
                  );
                },
                child: YtsModel(
                  image: movies[index].image,
                  name: movies[index].title,
                  year: movies[index].year,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
