import 'package:flutter/material.dart';
import 'package:rhythmix/Screens/song/audio_player.dart';
import 'package:rhythmix/Share/share_songs.dart';
import 'package:rhythmix/favorite_songs/add_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';

class Songsearch extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  // ignore: use_key_in_widget_constructors
  const Songsearch({Key? key});

  @override
  State<Songsearch> createState() => _ListallsongsforplaylistState();
}

class _ListallsongsforplaylistState extends State<Songsearch> {
  TextEditingController _searchController = TextEditingController();
  List<SongHive> _filteredSongs = [];

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _filteredSongs = songbox.values.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: const Center(
            child: Text(
          'Search Screen',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search for videos...',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: _filterSongs,
              ),
            ),
            Expanded(
              child: _filteredSongs.isEmpty
                  ? const Center(
                      child: Text(
                      "Nothing found!",
                      style: TextStyle(color: Colors.white),
                    ))
                  : ListView.builder(
                      itemCount: _filteredSongs.length * 2 - 1,
                      itemBuilder: (context, index) {
                        if (index.isOdd) {
                          return const Divider(color: Colors.black);
                        } else {
                          final itemIndex = index ~/ 2;
                          final song = _filteredSongs[itemIndex];
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AudioplayerScreen(
                                        audioPath: song.songfile,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  song.songfile.split('/').last,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.music_note),
                                ),
                                trailing: PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AudioplayerScreen(
                                              audioPath: song.songfile,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Play'),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        addsongToFavorites(
                                          song.songfile,
                                          context,
                                          songfavorite,
                                        );
                                      },
                                      child: const Text('Favorite'),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        shareSongs(song.songfile);
                                      },
                                      child: const Text('Share'),
                                    ),
                                  ],
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 2,
                                color: Colors.white,
                              )
                            ],
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterSongs(String query) {
    setState(() {
      _filteredSongs = songbox.values.where((song) {
        final songName = song.songfile.toLowerCase();
        return songName.contains(query.toLowerCase());
      }).toList();
    });
  }
}
