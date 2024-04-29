import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class Videohive {
  @HiveField(0)
  String videoFile;

  Videohive({required this.videoFile});

  get videoPath => null;

  get playlistId => null;
}

@HiveType(typeId: 2)
class VideoPlaylist {
  @HiveField(0)
  String name;

  @HiveField(1)
  List? videos;
  @HiveField(2)
  int id;

  VideoPlaylist({
    required this.name,
    this.videos,
    required this.id,
  });

  get playlistId => null;

  get videoFile => null;
}

@HiveType(typeId: 3)
class Videofavorite {
  @HiveField(0)
  String favoritevideo;

  Videofavorite({required this.favoritevideo});
}

@HiveType(typeId: 4)
class SongHive {
  @HiveField(0)
  String songfile;

  SongHive({required this.songfile});
}

@HiveType(typeId: 5)
class FavoriteSong {
  @HiveField(0)
  String favoritesong;

  FavoriteSong({required this.favoritesong});
}

@HiveType(typeId: 6)
class Songplaylist {
  @HiveField(0)
  String songpath;
  @HiveField(1)
  List? songs;
  @HiveField(2)
  int id;

  Songplaylist({required this.songpath, required this.songs, required this.id});

  String get songPath => songpath;
}

@HiveType(typeId: 7)
class Recentlyplayedvideo {
  @HiveField(0)
  String videoPath;
  @HiveField(1)
  Recentlyplayedvideo({
    required this.videoPath,
  });
}

@HiveType(typeId: 8)
class RecentlyplayedSong {
  @HiveField(0)
  // ignore: non_constant_identifier_names
  String SongPath;
  @HiveField(1)

  // ignore: non_constant_identifier_names
  RecentlyplayedSong({
    // ignore: non_constant_identifier_names
    required this.SongPath,
  });
}
