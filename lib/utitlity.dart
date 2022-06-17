import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

Future<void> launchMyUrl(
  String url,
) async {
  if (await urlLauncher.canLaunchUrl(Uri.parse(url))) {
    await urlLauncher.launchUrl(
      Uri.parse(url),
      mode: urlLauncher.LaunchMode.externalNonBrowserApplication,
    );
  } else {
    Get.defaultDialog(
      title: ("Make Choice"),
      content: const Text(
          "You don't have torrent to download this movie. Do you want to download it?"),
      actions: [
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () {
            launchMyUrl(
              'https://play.google.com/store/apps/details?id=com.bittorrent.client',
            );
          },
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}

Future<void> share(String title, String link) async {
    await FlutterShare.share(
      title: 'Share Movie',
      text: 'Share $title',
      linkUrl: link,
      chooserTitle: 'Example Chooser Title'
    );
  }
