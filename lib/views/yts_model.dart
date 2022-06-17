import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class YtsModel extends StatelessWidget {
  final String image;
  final String name;
  final String year;

  final double? height;
  const YtsModel(
      {required this.image, required this.name, required this.year,this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Tooltip(
                message: name,
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: height,
                  width: 300,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    "assets/img/loading.gif",
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            year,
            style: const TextStyle(
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
