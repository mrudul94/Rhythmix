import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/model.dart';
import 'package:rhythmix/Videoplaylist/Playlistvideoscreen.dart';

Future<List<VideoPlaylist>> getvideo() async {
  final boxvideoplaylist = await Hive.openBox<VideoPlaylist>('videoplaylistBox');
  return boxvideoplaylist.values.toList();
}

Future<void> addVideoToPlaylist(BuildContext context, Videohive video, int playlistId) async {
  try {
    final boxvideoplaylist = await Hive.openBox<VideoPlaylist>('videoplaylistBox');
    final playlist = await getvideo();
    
    bool videoAlreadyExists = false;

    

    playlist.forEach((element) {
      print('Inside forEach loop'); // Debug print statement
      print('Element ID: ${element.id}, Target ID: $playlistId'); // Debug print statement
      if (element.id == playlistId) {
        if (element.videos != null && element.videos!.contains(video.videoFile)) {
          print(element.id);
          videoAlreadyExists = true;
          print('${video.videoFile} already exists in the playlist.');
        } else {
          List<dynamic> temp = element.videos ?? [];
          temp.add(video.videoFile);
          print('Adding ${video.videoFile} to the playlist: $temp');
          final data = VideoPlaylist(name: element.name, id: element.id, videos: temp);
          boxvideoplaylist.put(data.id, data);
          
          // Navigate to PlaylistVideosPage after adding the video
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistVideosPage(data,), // Pass the updated playlist data
            ),
          );
        }          
      }
    });

    if (videoAlreadyExists) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Duplicate Song'),
            content: const Text('This song already exists in the playlist.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error adding video to playlist: $e');
    // Handle error gracefully, e.g., show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding video to playlist: $e'),
      ),
    );
  }
}