import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';

Future<void> openBoxes() async {
  boxvideo = await Hive.openBox<Videohive>('Videobox');
  playlistBox = await Hive.openBox<VideoPlaylist>('Playlistbox');
  boxFavorite = await Hive.openBox<Videofavorite>('Favoriteboc');
  songbox = await Hive.openBox<SongHive>('songbox');
  songfavorite = await Hive.openBox<FavoriteSong>('Favoritesong');
  songplaylistbox = await Hive.openBox<Songplaylist>('songplaylist');
  boxrecentlyplayedvideo =
      await Hive.openBox<Recentlyplayedvideo>('recentlyplayedvideo');
  boxrecentlyplayedsong =
      await Hive.openBox<RecentlyplayedSong>('Recentlyplayedsong');
}
