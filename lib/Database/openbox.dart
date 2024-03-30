import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/boxes.dart';
import 'package:rhythmix/Database/model.dart';

Future<void> openBoxes() async {
  boxvideo = await Hive.openBox<Videohive>('Videobox');
      playlistBox = await Hive.openBox<VideoPlaylist>('Playlistbox');
  boxFavorite = await Hive.openBox<videofavorite>('Favoriteboc');
   
  
}