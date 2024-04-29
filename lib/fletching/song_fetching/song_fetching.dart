import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/hive_items/add_to_hive.dart';

Future<List<SongModel>> fetchAndAddSongsToHive() async {
  final songs = await OnAudioQuery().querySongs(
    sortType: null,
    orderType: OrderType.ASC_OR_SMALLER,
    uriType: UriType.EXTERNAL,
    ignoreCase: true,
  );

  // Add fetched songs to Hive box
  await addSongsToHive(songs);

  return songs;
}
