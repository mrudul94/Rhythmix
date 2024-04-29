import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/song_playlist/song_playlist_screen.dart';

class SongplaylistHome extends StatefulWidget {
  const SongplaylistHome({super.key});

  @override
  State<SongplaylistHome> createState() => _SongplaylistHomeState();
}

class _SongplaylistHomeState extends State<SongplaylistHome> {
  late Box<Songplaylist>? songplaylistbox;

  @override
  void initState() {
    super.initState();
    openBoxes();
  }

  Future<void> openBoxes() async {
    await Hive.openBox<Songplaylist>('songplaylist');
    songplaylistbox = Hive.box<Songplaylist>('songplaylist');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: openBoxes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(color: Colors.black),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: songplaylistbox!.isEmpty
                        ? const Center(
                            child: Text(
                              'No playlist available',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                            ),
                            itemCount: songplaylistbox!.length,
                            itemBuilder: (context, index) {
                              final playlist = songplaylistbox!.getAt(index);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistSongsPage(
                                        playlistid: playlist!.id,
                                        playlistName: playlist.songpath,
                                        songs: playlist.songs?.cast<String>() ??
                                            [],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.black,
                                          ),
                                          child: const Icon(
                                            Icons.playlist_play,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                playlist!.songpath,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      _showDeletePlaylistDialog(
                                                          index);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      _showRenamePlaylistDialog(
                                                          playlist.id,
                                                          playlist.songpath);
                                                    },
                                                    child: const Text('Rename'),
                                                  ),
                                                ],
                                                child: const Icon(
                                                  Icons.more_vert,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 163, 163, 163),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 5)),
                        child: IconButton(
                          padding: const EdgeInsets.only(),
                          onPressed: _showAddsongPlaylistDialog,
                          icon: const Icon(Icons.add,
                              size: 50, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _showDeletePlaylistDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Playlist'),
        content: const Text('Are you sure you want to delete this playlist?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _onDeletePlaylist(index);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _onDeletePlaylist(int index) {
    songplaylistbox!.deleteAt(index);
    setState(() {});
  }

  void _showAddsongPlaylistDialog() {
    String playlistName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Playlist'),
        content: TextField(
          onChanged: (value) {
            playlistName = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter playlist name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (playlistName.isNotEmpty) {
                _onAddsongPlaylist(playlistName);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _onAddsongPlaylist(String name) async {
    int id = await addsongPlaylistName(name);
    if (id != -1) {
      setState(() {});
    }
  }

  Future<int> addsongPlaylistName(String name) async {
    try {
      final data = Songplaylist(
          songpath: name,
          songs: [],
          id: DateTime.now()
              .millisecondsSinceEpoch); // Using current timestamp as ID
      int? id = await songplaylistbox?.add(data);
      data.id = id!;
      await songplaylistbox!.put(id, data);
      setState(() {});
      return id;
    } catch (e) {
      return -1;
    }
  }

  void _showRenamePlaylistDialog(int id, String currentName) {
    String newName = currentName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(currentName),
        content: TextField(
          onChanged: (value) {
            newName = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter new name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newName.isNotEmpty && newName != currentName) {
                _onRenamePlaylist(id, newName); // Pass playlist ID here
                Navigator.pop(context);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _onRenamePlaylist(int id, String newName) {
    final playlist = songplaylistbox!.get(id); // Retrieve playlist by ID
    if (playlist != null) {
      playlist.songpath = newName;
      songplaylistbox!.put(id, playlist); // Update playlist with ID
      setState(() {});
    }
  }
}
