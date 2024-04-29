import 'package:flutter/material.dart';
import 'package:rhythmix/favorite_songs/add_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/Screens/song/audio_player.dart';
import 'package:rhythmix/share/share_songs.dart';
import 'package:rhythmix/song_playlist/song_list.dart';

class PlaylistSongsPage extends StatefulWidget {
  final List<String> songs;
  final String playlistName;
  // ignore: prefer_typing_uninitialized_variables
  final playlistid;

  const PlaylistSongsPage(
      {super.key,
      required this.songs,
      required this.playlistName,
      required this.playlistid});

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistSongsPageState createState() => _PlaylistSongsPageState();
}

class _PlaylistSongsPageState extends State<PlaylistSongsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: widget.songs.isEmpty
            ? const Center(
                child: Text(
                  'No songs found for this playlist.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'android/assets/images/Picsart_24-02-29_11-54-16-279.png',
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    widget.playlistName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.songs.length * 2 - 1,
                      itemBuilder: (context, index) {
                        if (index.isOdd) {
                          return const Divider(color: Colors.black);
                        } else {
                          final itemIndex = index ~/ 2;
                          final song = widget.songs[itemIndex];
                          return ListTile(
                            title: Text(
                              song.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.music_note,
                                color: Colors.black,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 24,
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      deleteVideo(itemIndex);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      addsongToFavorites(
                                          song, context, songfavorite);
                                    },
                                    child: const Text('add to favorite'),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      shareSongs(song);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioplayerScreen(
                                    audioPath: song,
                                  ),
                                ),
                              );
                              setState(() {
                                addToRecentlyPlayedSong(song);
                              });
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromARGB(255, 242, 0, 0), width: 5)),
            child: IconButton(
              padding: const EdgeInsets.only(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Listallsongsforplaylist(
                            playlistid: widget.playlistid)));
              },
              icon: const Icon(Icons.add,
                  size: 50, color: Color.fromARGB(255, 247, 0, 0)),
            ),
          ),
        ),
      ),
    );
  }

  void deleteVideo(int index) {
    setState(() {
      widget.songs.removeAt(index);
    });
  }
}
