import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rhythmix/Database/model.dart';
import 'package:rhythmix/Screens/video/Videoplayer.dart';
import 'package:rhythmix/Videoplaylist/listallvideoforplaylist.dart';
import 'package:rhythmix/Thumbnail/thumbnail.dart';
import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';

class PlaylistVideosPage extends StatefulWidget {
  final VideoPlaylist playlist;
  

  const PlaylistVideosPage(
    this.playlist, {super.key}); 

  @override
  State<PlaylistVideosPage> createState() => _PlaylistVideosPageState();
}

class _PlaylistVideosPageState extends State<PlaylistVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 27, 120, 219),
        elevation: 0,
        title: Text(widget.playlist.name),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: myGradient),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.playlist.videos!.length,
                itemBuilder: (context, index) {
                  final videoFile = widget.playlist.videos![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CustomVideoPlayer(
                            videoPath: videoFile,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 234, 254, 83),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: double.infinity,
                                    child: ValueListenableBuilder<Uint8List?>(
                                      valueListenable:
                                          generateThumbnailNotifier(videoFile),
                                      builder: (context, thumbnailData, child) {
                                        if (thumbnailData != null) {
                                          return Image.memory(
                                            thumbnailData,
                                            fit: BoxFit.cover,
                                          );
                                        } else {
                                          return Image.asset(
                                            'android/assets/images/Placeholder image.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            deleteVideo(index);
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Text(
                              videoFile.split('/').last,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton.large(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            const LisstallVideo())); 
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  void deleteVideo(int index) {
    setState(() {
      widget.playlist.videos!.removeAt(index);
      
    });
  }
}
