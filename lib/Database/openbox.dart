import 'package:Rhythmix/Database/boxes.dart';
import 'package:Rhythmix/Database/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> openBoxes() async {
  boxvideo = await Hive.openBox<Videohive>('Videobox');
  boxvideoplaylist = await Hive.openBox<videoplaylist>('Playlistbox');
  boxFavorite = await Hive.openBox<videofavorite>('Favoriteboc');

}