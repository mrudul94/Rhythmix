import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Videoplaylist/playlist_video_screen.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/showdialoges/show_dialog.dart';

class VideoPlayLists extends StatefulWidget {
  const VideoPlayLists({super.key});

  @override
  State<VideoPlayLists> createState() => _VideoPlayListsState();
}

class _VideoPlayListsState extends State<VideoPlayLists> {
  late Box<VideoPlaylist>? playlistBox;
  @override
  void initState() {
    super.initState();
    openBoxs();
  }

  Future<void> openBoxs() async {
    await Hive.openBox<VideoPlaylist>('videoplaylistBox');
    playlistBox = Hive.box<VideoPlaylist>('videoplaylistBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: openBoxs(), // Wait for the initialization of playlistBox
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If initialization is complete, build the UI
            return Container(
              decoration: const BoxDecoration(color: Colors.black),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<Box<VideoPlaylist>>(
                      valueListenable: playlistBox!.listenable(),
                      builder: (context, box, _) {
                        if (box.isEmpty) {
                          // If the box is empty, show a message
                          return const Center(
                            child: Text(
                              'No playlists available',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          );
                        } else {
                          // If the box is not empty, show the playlists
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              final playlist = box.getAt(index);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          PlaylistVideosPage(playlist!),
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
                                            Icons.file_copy,
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
                                                playlist!.name,
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
                                                            index,
                                                            playlist.name);
                                                      },
                                                      child:
                                                          const Text('Rename'))
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
                          );
                        }
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
                          onPressed: _showAddPlaylistDialog,
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
            // If initialization is not complete, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _showDeletePlaylistDialog(int index) {
    showDeletePlaylistDialog(context, _onDeletePlaylist, index);
  }

  void _onDeletePlaylist(int index) {
    playlistBox!.deleteAt(index);
    setState(() {});
  }

  void _showAddPlaylistDialog() {
    showAddPlaylistDialog(context, _onAddPlaylist);
  }

  Future<void> _onAddPlaylist(String name) async {
    int id = await addPlayListNamevideo(name);
    if (id != -1) {
      setState(() {});
    } else {
      // Handle error if needed
    }
  }

  Future<int> addPlayListNamevideo(String name) async {
    try {
      final Box<VideoPlaylist> playlistBox =
          Hive.box<VideoPlaylist>('videoplaylistBox');
      final data = VideoPlaylist(
        name: name,
        id: -1,
        videos: [],
      );
      int id = await playlistBox.add(data);
      data.id = id;
      await playlistBox.put(id, data);

      // Force rebuild of the UI
      setState(() {});

      return id;
    } catch (e) {
      return -1;
    }
  }

  void _showRenamePlaylistDialog(int index, String currentName) {
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
                _onRenamePlaylist(index, newName);
                Navigator.pop(context);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _onRenamePlaylist(int index, String newName) {
    final playlist = playlistBox!.getAt(index);
    playlist!.name = newName;
    playlistBox!.put(index, playlist);
    setState(() {});
  }
}
