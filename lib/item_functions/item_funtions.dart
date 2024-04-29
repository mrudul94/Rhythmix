import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/screens/song/audio_player.dart';

Widget buildVideoItem(BuildContext context, int index) {
  final video = boxvideo.getAt(boxvideo.length - 1 - index);

  if (video == null) {
    return Container();
  }

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => CustomVideoPlayer(
            videoPath: video.videoFile,
          ),
        ),
      );
      addToRecentlyPlayed(video.videoFile);
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SizedBox(
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: ValueListenableBuilder<Uint8List?>(
                      valueListenable: generateThumbnailNotifier(
                          video.videoFile.createPath()),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video.videoFile.split('/').last,
              style: const TextStyle(
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
}

Widget buildSongItem(BuildContext context, int index) {
  final song = songbox.getAt(songbox.length - 1 - index);

  return GestureDetector(
    onTap: () {
      addToRecentlyPlayedSong(song!.songfile);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => AudioplayerScreen(audioPath: song.songfile)));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: songbox.isEmpty
          ? Image.asset(
              'android/assets/images/Placeholder image.jpg',
              fit: BoxFit.cover,
            )
          : Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    song!.songfile.split('/').last,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
    ),
  );
}
