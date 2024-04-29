import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/item_functions/item_funtions.dart';

Widget buildRecentlyPlayedVideos() {
  return Expanded(
    child: boxrecentlyplayedvideo.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) => buildVideoItem(context, index),
              itemCount: 2,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final video = boxrecentlyplayedvideo
                    .getAt(boxrecentlyplayedvideo.length - 1 - index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => CustomVideoPlayer(
                          videoPath: video!.videoPath,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 120,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ValueListenableBuilder<Uint8List?>(
                              valueListenable: generateThumbnailNotifier(
                                  video!.videoPath.createPath()),
                              builder: (context, thumbnailData, child) {
                                if (thumbnailData != null) {
                                  return Image.memory(
                                    thumbnailData,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.asset(
                                    'android/assets/images/Placeholder image.jpg',
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            video.videoPath.split('/').last,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: boxrecentlyplayedvideo.length > 2
                  ? 2
                  : boxrecentlyplayedvideo.length,
            ),
          ),
  );
}
