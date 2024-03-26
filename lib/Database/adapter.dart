import 'package:Rhythmix/Database/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> registerAdapter() async{
  Hive.registerAdapter(VideohiveAdapter());
  Hive.registerAdapter(videoplaylistAdapter());
  Hive.registerAdapter(videofavoriteAdapter());
}