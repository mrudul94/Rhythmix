// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/videoplaylist/playlist_video_screen.dart';
import 'package:rhythmix/hive_items/model.dart';

Future<List<VideoPlaylist>> getvideo() async {
  final boxvideoplaylist =
      await Hive.openBox<VideoPlaylist>('videoplaylistBox');
  return boxvideoplaylist.values.toList();
}

Future<void> addVideoToPlaylist(
    BuildContext context, Videohive video, int playlistId) async {
  try {
    final boxvideoplaylist =
        await Hive.openBox<VideoPlaylist>('videoplaylistBox');
    final playlist = await getvideo();

    bool videoAlreadyExists = false;

    playlist.forEach((element) {
      if (element.id == playlistId) {
        if (element.videos != null &&
            element.videos!.contains(video.videoFile)) {
          videoAlreadyExists = true;
        } else {
          List<dynamic> temp = element.videos ?? [];
          temp.add(video.videoFile);
          final data =
              VideoPlaylist(name: element.name, id: element.id, videos: temp);
          boxvideoplaylist.put(data.id, data);

          // Show a SnackBar to notify the user that the video has been added to the playlist
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Video added to playlist.'),
            ),
          );

          // Navigate to PlaylistVideosPage after adding the video
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlaylistVideosPage(data), // Pass the updated playlist data
            ),
          );
        }
      }
    });

    if (videoAlreadyExists) {
      // Show a SnackBar to notify the user that the video is already in the playlist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('This video already exists in the playlist.'),
        ),
      );
    }
  } catch (e) {
    // Handle error gracefully, e.g., show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding video to playlist: $e'),
      ),
    );
  }
}
