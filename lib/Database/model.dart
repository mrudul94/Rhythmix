import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class Videohive {
  @HiveField(0)
  String videoFile;

  Videohive({required this.videoFile});

  get videoPath => null;

 
}
@HiveType(typeId: 2)
class videoplaylist {
  @HiveField(0)
  String name;

  @HiveField(1)
  List? videos;

  @HiveField(2)
  int id;

  videoplaylist({required this.name,required this.videos,required this.id});
}
@HiveType(typeId: 3)
class videofavorite {
  @HiveField(0)
  String  Favoritevideo;

  videofavorite({required this.Favoritevideo});

  
}