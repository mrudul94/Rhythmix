import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Share/share_video.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/hive_items/open_box.dart';

class RecentlyPlayedVideosScreen extends StatefulWidget {
  const RecentlyPlayedVideosScreen({super.key});

  @override
  State<RecentlyPlayedVideosScreen> createState() =>
      _RecentlyPlayedVideosScreenState();
}

class _RecentlyPlayedVideosScreenState
    extends State<RecentlyPlayedVideosScreen> {
  @override
  void initState() {
    super.initState();
    openBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Recently Played Videos',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color.fromARGB(255, 255, 0, 0)),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: boxrecentlyplayedvideo.isEmpty
                ? const Center(
                    child: Text(
                      'No Recently Played Videos',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        // ignore: non_constant_identifier_names
                        final VideoMetaData = boxrecentlyplayedvideo
                            .getAt(boxrecentlyplayedvideo.length - 1 - index);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CustomVideoPlayer(
                                  videoPath: VideoMetaData!.videoPath,
                                ),
                              ),
                            );
                            setState(() {
                              addToRecentlyPlayed(VideoMetaData!.videoPath);
                            });
                          },
                          child: Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: SizedBox(
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ValueListenableBuilder<
                                                Uint8List?>(
                                              valueListenable:
                                                  generateThumbnailNotifier(
                                                      VideoMetaData!.videoPath
                                                          .createPath()),
                                              builder: (context, thumbnailData,
                                                  child) {
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
                                        Positioned(
                                          top: 10,
                                          right: 5,
                                          child: PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                onTap: () {
                                                  addToFavorites(
                                                      VideoMetaData.videoPath,
                                                      context,
                                                      boxFavorite);
                                                },
                                                child: const Text(
                                                    'Add to Favorite'),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {
                                                  shareVideo(
                                                      VideoMetaData.videoPath);
                                                },
                                                child: const Text('Share'),
                                              ),
                                            ],
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 130),
                                              child: Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: Text(
                                    VideoMetaData.videoPath.split('/').last,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: boxrecentlyplayedvideo.length,
                    ),
                  ),
          ),
        ],
      )),
    );
  }
}

void addToRecentlyPlayed(String videoPath) {
  // Check if the video is already in the list
  bool alreadyExists = boxrecentlyplayedvideo.values
      .any((video) => video.videoPath == videoPath);

  // If the video doesn't exist in the list, add it
  if (!alreadyExists) {
    var recentlyPlayedVideo = Recentlyplayedvideo(videoPath: videoPath);
    boxrecentlyplayedvideo.add(recentlyPlayedVideo);
  } else {
    // Find the index of the existing video
    int existingIndex = boxrecentlyplayedvideo.values
        .toList()
        .indexWhere((video) => video.videoPath == videoPath);

    // Remove the existing instance from its current position
    var existingVideo = boxrecentlyplayedvideo.getAt(existingIndex);
    boxrecentlyplayedvideo.deleteAt(existingIndex);

    // Add the existing video to the last position of the list
    boxrecentlyplayedvideo.add(existingVideo!);
  }
}
