import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/fletching/song_fetching/song_fetching.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/screens/song/audio_player.dart';
import 'package:rhythmix/Share/share_songs.dart';
import 'package:rhythmix/favorite_songs/add_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/hive_items/open_box.dart';
import 'package:rhythmix/song_playlist/add_song_playlist.dart';

class AudioFunction extends StatefulWidget {
  const AudioFunction({super.key});

  @override
  State<AudioFunction> createState() => _AudioFunctionState();
}

class _AudioFunctionState extends State<AudioFunction> {
  
  @override
void initState() {
  super.initState();
  openBoxes();
  
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: fetchAndAddSongsToHive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Text("Nothing found!",style: TextStyle(color: Colors.white),);
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length * 2 - 1,
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return const Divider(color: Colors.white);
              } else {
                final itemIndex = index ~/ 2;
                final song = snapshot.data![songbox.length - 1 - itemIndex];
                return ListTile(
                  title: Text(
                    song.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  
                  leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.music_note,color: Colors.black,)),
                  trailing: SizedBox(
                    width: 24,
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            onTap: () {
                              addToRecentlyPlayedSong(song.data);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioplayerScreen(
                                    audioPath: song.data,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Play')),
                        PopupMenuItem(
                            onTap: () {
                              _showAllPlaylistsDialog(song, context);
                            },
                            child: const Text('Add to Playlist')),
                        PopupMenuItem(
                            onTap: () {
                              addsongToFavorites(
                                  song.data, context, songfavorite);
                            },
                            child: const Text('Favorite')),
                        PopupMenuItem(onTap: () {
                          shareSongs(song.data);
                        }, child: const Text('Share')),
                      ],
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.more_vert, size: 30, weight: 20,color: Colors.white,),
                      ),
                    ),
                  ),
                  onTap: ()  {
                    
                   addToRecentlyPlayedSong(song.data);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioplayerScreen(
                          audioPath: song.data,
                        ),
                      ),
                    );
                   
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  void _showAllPlaylistsDialog(SongModel song, BuildContext context) async {
  try {
    final songPlaylistBox = Hive.box<Songplaylist>('songplaylist');
    // ignore: unnecessary_null_comparison
    if (songPlaylistBox == null) {
      // Handle case where songPlaylistBox is null
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Playlist'),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: songPlaylistBox.length,
            itemBuilder: (context, index) {
              final playlist = songPlaylistBox.getAt(index);
              if (playlist == null) {
                return const SizedBox(); // Skip this item if it's null
              }
              return ListTile(
                title: Text(playlist.songpath),
                onTap: () async {
                  Navigator.pop(context);
                  // Await the addVideoToPlaylist function
                  await addsongToPlaylist(context, song, playlist.id);
                },
              );
            },
          ),
        );
      },
    );
  } catch (e) {
    // Handle error gracefully, e.g., show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error showing playlist dialog: $e'),
      ),
    );
  }
}
}
void onSkipPrevioussong(BuildContext context, String songPath) {
  int currentIndex = songbox.values
      .toList()
      .indexWhere((song) => song.songfile == songPath); // Corrected comparison here
  if (currentIndex > 0) {
    String previousSongPath =
        songbox.getAt(currentIndex - 1)?.songfile ?? '';
    if (previousSongPath.isNotEmpty) {
      addToRecentlyPlayedSong(previousSongPath);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => AudioplayerScreen(audioPath: previousSongPath)
        ),
      );
    }
  }
}
