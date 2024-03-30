import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/model.dart';

import 'package:rhythmix/Videoplaylist/Playlistvideoscreen.dart';
import 'package:rhythmix/showdialoges/showdialoge.dart';
import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';

class VideoPlayLists extends StatefulWidget {
  const VideoPlayLists({Key? key}) : super(key: key);

  @override
  State<VideoPlayLists> createState() => _VideoPlayListsState();
}

class _VideoPlayListsState extends State<VideoPlayLists> {
  late Box<VideoPlaylist>? playlistBox;
  @override
  void initState() {
    super.initState();
    openBo();
  }

  Future<void> openBo() async {
    await Hive.openBox<VideoPlaylist>('videoplaylistBox');
    playlistBox = Hive.box<VideoPlaylist>('videoplaylistBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: openBo(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return loading indicator while opening box
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Return error message if an error occurs
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Once box is opened, build the UI
            return buildUI();
          }
        },
      ),
    );
  }

  Widget buildUI() {
    return Container(
      decoration: const BoxDecoration(gradient: myGradient),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<VideoPlaylist>>(
              valueListenable: playlistBox!.listenable(),
              builder: (context, box, _) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    PlaylistVideosPage(playlist!)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            _showDeletePlaylistDialog(
                                              index,
                                            );
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                      child: const Icon(
                                        Icons.more_vert,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 163, 163, 163),
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
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showAddPlaylistDialog,
            child: const Text('Add Playlist'),
          ),
        ],
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
      final data = VideoPlaylist(name: name, id: -1, videos: []);
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
}
