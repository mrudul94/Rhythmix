// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Share/share_video.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:video_player/video_player.dart';

void onSkipPrevious(BuildContext context, String videoPath) {
  int currentIndex = boxvideo.values
      .toList()
      .indexWhere((video) => video.videoFile == videoPath);
  if (currentIndex > 0) {
    String previousVideoPath =
        boxvideo.getAt(currentIndex - 1)?.videoFile ?? '';
    if (previousVideoPath.isNotEmpty) {
      addToRecentlyPlayed(previousVideoPath);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => CustomVideoPlayer(
            videoPath: previousVideoPath,
          ),
        ),
      );
    }
  }
}

Widget buildDefaultVideoPlayer({
  required VideoPlayerController videoController,
  required double sliderValue,
  required bool showControls,
  required Function(bool) setIsFullScreen,
  required Function(double) onSliderChanged,
  required Function() onRewind,
  required Function() onPlayPause,
  required Function() onFastForward,
  required BuildContext context,
  required String videoPath,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  return
   AspectRatio(
    aspectRatio: videoController.value.aspectRatio,
    child: Stack(
      children: [
        VideoPlayer(videoController),
        if (showControls)
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  Slider(
                    activeColor: Colors.red,
                    inactiveColor: Colors.black,
                    value: sliderValue,
                    min: 0,
                    max: videoController.value.duration.inMilliseconds
                        .toDouble(),
                    onChanged: onSliderChanged,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setIsFullScreen(true);
                        },
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          onSkipPrevious(context, videoPath); // Call onSkipPrevious here
                        },
                        icon: const Icon(Icons.skip_previous, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          onRewind();
                        },
                        icon: const Icon(Icons.replay_10, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: onPlayPause,
                        icon: Icon(
                          videoController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: onFastForward,
                        icon: const Icon(Icons.forward_10, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          int currentIndex = boxvideo.values
                              .toList()
                              .indexWhere(
                                  (video) => video.videoFile == videoPath);
                          if (currentIndex < boxvideo.length - 1) {
                            String nextVideoPath =
                                boxvideo.getAt(currentIndex + 1)?.videoFile ??
                                    '';
                            if (nextVideoPath.isNotEmpty) {
                              addToRecentlyPlayed(nextVideoPath);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => CustomVideoPlayer(
                                    videoPath: nextVideoPath,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              addToFavorites(videoPath, context, boxFavorite);
                            },
                            child: const Text('Add to Favorite'),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              shareVideo(videoPath);
                            },
                            child: const Text('Share'),
                          ),
                        ],
                        child: const Icon(
                          Icons.more_vert,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
