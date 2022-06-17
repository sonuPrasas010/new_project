import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yts_movie/controller/home_controller.dart';
import 'package:yts_movie/controller/info_controller.dart';
import 'package:yts_movie/views/yts_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utitlity.dart';

class Details extends StatelessWidget {
  final String title, link;
  late InfoController _controller;
  Details({required this.title, required this.link}) {
    _controller = Get.put(InfoController(link), tag: link);
  }
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Obx(
          () => _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _controller.info.isEmpty
                  ? Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _controller.refresh();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          "Refresh",
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      // physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 380,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 280,
                                  width: double.maxFinite,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        _controller.info['backgroundImage'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  left: 10,
                                  child: IconButton(
                                    onPressed: () => Get.back(),
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 100,
                                    left: 120,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 200,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            _controller.info['title'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            _controller.info['genres'],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    )),
                                Positioned(
                                  top: 170,
                                  left: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star_border_outlined,
                                            color: Colors.white70,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _controller.info['imdbRating'],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.timelapse_outlined,
                                            color: Colors.white70,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            " ${_controller.info['runtime']} min",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.white70,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _controller.info['year'].toString(),
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.audiotrack_sharp,
                                            color: Colors.white70,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _controller.info['lang'] ?? "en",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 280,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    // width: double.maxFinite,
                                    height: 120,
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF4F4F4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 180,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.favorite_border_outlined,
                                              size: 20,
                                            ),
                                            Text(
                                              "Wishlist",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                share(
                                                    title,
                                                    _controller
                                                        .info['shareLink']);
                                              },
                                              child: const Icon(
                                                Icons.share_outlined,
                                                size: 20,
                                              ),
                                            ),
                                            const Text(
                                              "Share",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 170,
                                  left: 20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          _controller.info['image'].toString(),
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 250,
                                  left: 60,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.play_circle_fill_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      launchMyUrl(
                                        "https://www.youtube.com/watch?v=${_controller.info['yt_torrent_code']}",
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.info['title'],
                                  style: const TextStyle(
                                    color: Color(0xff9292F8),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  "Overview",
                                  style: TextStyle(
                                    color: Color(0xff5F5F5F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

//                             Container(
//                                 height: 330,
//                                 child: NativeAdmob(
//                                   adUnitID:
//                                       "ca-app-pub-3940256099942544/1044960115",
//                                   loading: const Center(
//                                       child: CircularProgressIndicator()),
//                                   error: const SizedBox(),
//                                   controller: NativeAdmobController(),
//                                   type: NativeAdmobType.full,
//                                   options: const NativeAdmobOptions(
//                                     ratingColor: Colors.green,
// // Others ...
//                                   ),
//                                 )),

                                // if (_controller.bannerAdIsLoaded.value)
                                //   Container(
                                //       height: _controller.bannerAd?.size.height
                                //               .toDouble() ??
                                //           100,
                                //       width: _controller.bannerAd?.size.width
                                //               .toDouble() ??
                                //           100,
                                //       child: AdWidget(ad: _controller.bannerAd!)),
                                Text(
                                  _controller.info['summary'].toString(),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(
                                      0xff5F5F5F,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Cast",
                                  style: TextStyle(
                                    color: Color(0xff5F5F5F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(
                                  runSpacing: 8,
                                  spacing: 15,
                                  runAlignment: WrapAlignment.spaceBetween,
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  children: [
                                    for (var cast in _controller.info["cast"])
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              cast["url_small_image"] ??
                                                  "https://img.yts.mx/assets/images/actors/thumb/default_avatar.jpg",
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: "${cast['name']} as\n",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Giane Gothic",
                                                  fontSize: 11,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${cast['character_name']}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontFamily: "Giane Gothic",
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // FacebookNativeAd(
                                //   placementId:
                                //       "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
                                //   adType: NativeAdType.NATIVE_AD_VERTICAL,
                                //   width: double.infinity,
                                //   height: 300,
                                //   backgroundColor: Colors.blue,
                                //   titleColor: Colors.white,
                                //   descriptionColor: Colors.white,
                                //   buttonColor: Colors.deepPurple,
                                //   buttonTitleColor: Colors.white,
                                //   buttonBorderColor: Colors.white,
                                //   keepAlive:
                                //       true, //set true if you do not want adview to refresh on widget rebuild
                                //   keepExpandedWhileLoading:
                                //       false, // set false if you want to collapse the native ad view when the ad is loading
                                //   expandAnimationDuraion:
                                //       300, //in milliseconds. Expands the adview with animation when ad is loaded
                                //   listener: (result, value) {
                                //     print("Native Ad: $result --> $value");
                                //     if (result == NativeAdResult.CLICKED) {
                                //       print(" facebook native ad clicked");
                                //     }
                                //   },
                                // ),
                                for (var torrents
                                    in _controller.info['torrents'])
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                          offset: Offset(5, 5),
                                        ),
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                          offset: Offset(-5, -5),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            torrents['quality'],
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            torrents['type'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Size: ${torrents['size']}"
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xff9292F8),
                                                  elevation: 5,
                                                  shadowColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  launchMyUrl(
                                                    torrents['hashLink'],
                                                  );
                                                },
                                                icon:
                                                    const Icon(Icons.download),
                                                label: const Text("Download"),
                                              ),
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xff9292F8),
                                                  elevation: 5,
                                                  shadowColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                    ClipboardData(
                                                      text:
                                                          "${torrents['hashLink']}",
                                                    ),
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Magnet url Copied to Clipboard"),
                                                  ));
                                                },
                                                icon: const Icon(Icons.copy),
                                                label: const Text("Copy Link"),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xff9292F8),
                                              elevation: 5,
                                              shadowColor: Colors.blue,
                                            ),
                                            onPressed: () {
                                              Get.defaultDialog(
                                                title: "Coming Soon",
                                                middleText: "Under Development",
                                              );

                                              // Get.to(() => InAppWebView(
                                              //       initialOptions:
                                              //           InAppWebViewGroupOptions(
                                              //               crossPlatform:
                                              //                   InAppWebViewOptions(
                                              //         useShouldOverrideUrlLoading:
                                              //             true,
                                              //       )),
                                              //       initialUrlRequest: URLRequest(
                                              //         url: Uri.parse(
                                              //             "https://tormovie.online/videoplayer?v=${torrents['hashLink']}"),
                                              //       ),
                                              //       shouldOverrideUrlLoading:
                                              //           (_, action) async {
                                              //         return NavigationActionPolicy
                                              //             .CANCEL;
                                              //       },
                                              //     ));

                                              // MyChromeSafariBrowser().open(
                                              //     url: Uri.parse(
                                              //         "https://tormovie.online/videoplayer?v=${torrents['hashLink']}"),
                                              //     options:
                                              //         ChromeSafariBrowserClassOptions(
                                              //             android:
                                              //                 AndroidChromeCustomTabsOptions(
                                              //       // isTrustedWebActivity: true,
                                              //       isSingleInstance: true,

                                              //       showTitle: true,
                                              //     )));

                                              // launchMyUrl(
                                              //     "https://tormovie.online/videoplayer?v=${torrents['hashLink']}");
                                            },
                                            icon: const Icon(Icons.play_arrow),
                                            label: const Text("Play"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                const Text(
                                  "Recommendation",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 176,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: false,
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        _controller.info["similarList"].length,
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
                                      width: 10,
                                    ),
                                    itemBuilder: (_, index) => GestureDetector(
                                      onTap: () => Get.to(
                                        () => Details(
                                          title: _controller.info["similarList"]
                                              [index]["title"],
                                          link: _controller.info["similarList"]
                                              [index]["link"],
                                        ),
                                        preventDuplicates: false,
                                      ),
                                      child: YtsModel(
                                        image: _controller.info["similarList"]
                                                [index]['image']
                                            .toString(),
                                        name: _controller.info["similarList"]
                                                [index]['title']
                                            .toString(),
                                        year: _controller.info["similarList"]
                                                [index]['year'] ??
                                            "0000",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ));
  }
}
