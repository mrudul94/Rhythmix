import 'package:flutter/material.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/Screens/song/audio_player.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/item_functions/item_funtions.dart';

Widget buildRecentlyPlayedSongs() {
  return Expanded(
    child: boxrecentlyplayedsong.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => buildSongItem(context, index),
              itemCount: songbox.length > 2 ? 2 : songbox.length,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final song = boxrecentlyplayedsong
                    .getAt(boxrecentlyplayedsong.length - 1 - index);
                return GestureDetector(
                  onTap: () {
                    addToRecentlyPlayedSong(song!.SongPath);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) =>
                                AudioplayerScreen(audioPath: song.SongPath)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            song!.SongPath.split('/').last,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: boxrecentlyplayedsong.length > 2
                  ? 2
                  : boxrecentlyplayedsong.length,
            ),
          ),
  );
}
