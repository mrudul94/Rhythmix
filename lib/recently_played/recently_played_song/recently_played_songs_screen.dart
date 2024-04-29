import 'package:flutter/material.dart';
import 'package:rhythmix/Screens/song/audio_player.dart';
import 'package:rhythmix/Share/share_songs.dart';
import 'package:rhythmix/favorite_songs/add_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/hive_items/open_box.dart';

class RecentlyPlayedSongsScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RecentlyPlayedSongsScreen({Key? key});

  @override
  State<RecentlyPlayedSongsScreen> createState() =>
      _RecentlyPlayedSongsScreenState();
}

class _RecentlyPlayedSongsScreenState extends State<RecentlyPlayedSongsScreen> {
  @override
  void initState() {
    super.initState();
    openBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Recently Played Songs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color.fromARGB(255, 255, 0, 0),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: boxrecentlyplayedsong.isEmpty
                  ? const Center(
                      child: Text(
                        'No Recently Played songs',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: boxrecentlyplayedsong.length,
                      itemBuilder: (context, index) {
                        final song = boxrecentlyplayedsong
                            .getAt(boxrecentlyplayedsong.length - 1 - index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    song!.SongPath.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  leading: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    child: Icon(Icons.music_note,
                                        color: Colors.black),
                                  ),
                                  trailing: SizedBox(
                                    width: 24,
                                    child: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            addsongToFavorites(song.SongPath,
                                                context, songfavorite);
                                          },
                                          child: const Text('Favorite'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            shareSongs(song.SongPath);
                                          },
                                          child: const Text('Share'),
                                        ),
                                      ],
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 30,
                                          weight: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    addToRecentlyPlayedSong(song.SongPath);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AudioplayerScreen(
                                          audioPath: song.SongPath,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void addToRecentlyPlayedSong(String songPath) {
  // Check if the song is already in the list
  bool alreadyExists = boxrecentlyplayedsong.values
      .toList()
      .any((song) => song.SongPath == songPath);

  // If the song doesn't exist in the list, add it
  if (!alreadyExists) {
    var recentlyPlayedSong = RecentlyplayedSong(SongPath: songPath);
    boxrecentlyplayedsong.add(recentlyPlayedSong);
  } else {
    // Convert to a List and then find the index of the existing song
    int existingIndex = boxrecentlyplayedsong.values
        .toList()
        .indexWhere((song) => song.SongPath == songPath);

    // Remove the existing instance from its current position
    var existingSong = boxrecentlyplayedsong.getAt(existingIndex);
    boxrecentlyplayedsong.deleteAt(existingIndex);

    // Add the existing song to the last position of the list
    boxrecentlyplayedsong.add(existingSong!);
  }
}
