import 'package:Rhythmix/Database/addtohive.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';

Future<void> fetchVideo() async {
    try {
      List<VideoDetails> videoPath = await ListAllVideos().getAllVideosPath();
      if (videoPath.isNotEmpty) {
        List<dynamic> paths = [];
        for (var element in videoPath) {
          paths.add(element.videoPath);
        }
        addVideosToHive(paths);
      }
    // ignore: empty_catches
    } catch (e) {
    
    }
  }
   
   