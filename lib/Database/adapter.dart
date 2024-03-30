
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/model.dart';

Future<void> registerAdapter() async{
  Hive.registerAdapter(VideohiveAdapter());
   Hive.registerAdapter(VideoPlaylistAdapter());
  Hive.registerAdapter(videofavoriteAdapter());
 
}