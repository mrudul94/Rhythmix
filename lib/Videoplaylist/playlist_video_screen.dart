import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/videoplaylist/playlist_video_list.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/share/share_video.dart';

class PlaylistVideosPage extends StatefulWidget {
  final VideoPlaylist playlist;

  const PlaylistVideosPage(
    this.playlist, {
    super.key,
  });

  @override
  State<PlaylistVideosPage> createState() => _PlaylistVideosPageState();
}

class _PlaylistVideosPageState extends State<PlaylistVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Image.asset(
            'android/assets/images/Picsart_24-02-29_11-54-16-279.png',
            height: 150,
            color: Colors.red,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.playlist.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            widget.playlist.videos!.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          setState(() {
                            addToRecentlyPlayed(videoFile);
                          });
                        },
                        child: Card(
                          color: Colors.transparent,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SizedBox(
                                          height: 120,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ValueListenableBuilder<
                                                Uint8List?>(
                                              valueListenable:
                                                  generateThumbnailNotifier(
                                                      videoFile
                                                          .toString()
                                                          .createPath()),
                                              builder: (context, thumbnailData,
                                                  child) {
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
                                            PopupMenuItem(
                                              onTap: () {
                                                addToFavorites(videoFile,
                                                    context, boxFavorite);
                                              },
                                              child:
                                                  const Text('add to favorite'),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                shareVideo(videoFile);
                                              },
                                              child: const Text('share'),
                                            ),
                                          ],
                                          child: const Icon(
                                            Icons.more_vert,
                                            size: 30,
                                            color: Colors.white,
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
                                    color: Colors.white,
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
                  color: const Color.fromARGB(255, 255, 0, 0), width: 5),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) =>
                        LisstallVideo(playlistid: widget.playlist.id),
                  ),
                );
              },
              icon: const Icon(Icons.add,
                  size: 50, color: Color.fromARGB(255, 255, 0, 0)),
            ),
          ),
        ),
      ),
    );
  }

  void deleteVideo(int index) {
    setState(() {
      widget.playlist.videos!.removeAt(index);
    });
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          Text(
            'No videos found for this playlist.',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
