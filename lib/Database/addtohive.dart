import 'package:Rhythmix/Database/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addVideosToHive(List<dynamic> videoPaths) async {
  final Box<Videohive> boxvideo = await Hive.openBox<Videohive>('Videobox');

  for (var videoPath in videoPaths) {
    final video = Videohive(videoFile: videoPath.toString(),);
    // print('...................${video.name}');
    await boxvideo.add(video);

    
  }
}