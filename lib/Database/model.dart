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

  VideoPlaylist({required this.name, this.videos, required this.id});

  get playlistId => null;

  get videoFile => null;
}
@HiveType(typeId: 3)
class videofavorite {
  @HiveField(0)
  String  Favoritevideo;

  videofavorite({required this.Favoritevideo});

  
}
