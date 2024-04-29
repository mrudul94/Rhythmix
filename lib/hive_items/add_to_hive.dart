import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/hive_items/model.dart';

Future<void> addVideosToHive(List<dynamic> videoPaths) async {
  final Box<Videohive> boxvideo = await Hive.openBox<Videohive>('Videobox');

  for (var videoPath in videoPaths) {
    final video = Videohive(videoFile: videoPath.toString());

    // Check if the video already exists in the box
    bool videoExists = boxvideo.values
        .any((existingvideo) => existingvideo.videoFile == video.videoFile);
    if (!videoExists) {
      await boxvideo.add(video);
    }
  }
}

Future<void> addSongsToHive(List<SongModel> songs) async {
  final Box<SongHive> songbox = await Hive.openBox<SongHive>('Songbox');

  for (var song in songs) {
    final songFilePath =
        song.data.toString(); // Assuming data holds the file path

    // Check if the song already exists in the box
    bool songExists = songbox.values
        .any((existingSong) => existingSong.songfile == songFilePath);

    if (!songExists) {
      await songbox.add(SongHive(songfile: songFilePath));
    }
  }
}
