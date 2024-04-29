import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/hive_items/model.dart';

Future<void> registerAdapter() async {
  Hive.registerAdapter(VideohiveAdapter());
  Hive.registerAdapter(VideoPlaylistAdapter());
  Hive.registerAdapter(VideofavoriteAdapter());
  Hive.registerAdapter(SongHiveAdapter());
  Hive.registerAdapter(FavoriteSongAdapter());
  Hive.registerAdapter(SongplaylistAdapter());
  Hive.registerAdapter(RecentlyplayedvideoAdapter());
  Hive.registerAdapter(RecentlyplayedSongAdapter());
}
