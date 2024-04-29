// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/videoplaylist/playlist_function.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/screens/video/video_player.dart';

class LisstallVideo extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final playlistid;

  const LisstallVideo({super.key, required this.playlistid});

  @override
  State<LisstallVideo> createState() => _LisstallVideoState();
}

class _LisstallVideoState extends State<LisstallVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('All Videos'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: boxvideo.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  itemBuilder: (context, index) {
                    final video = boxvideo.getAt(index);

                    if (video == null) {
                      return Container();
                    }

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: ValueListenableBuilder<Uint8List?>(
                        valueListenable: generateThumbnailNotifier(
                          video.videoFile.createPath(),
                        ),
                        builder: (context, thumbnailData, child) {
                          if (thumbnailData != null) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.memory(
                                  thumbnailData,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'android/assets/images/Placeholder image.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      title: Text(
                        video.videoFile.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // Await the addVideoToPlaylist function
                          await addVideoToPlaylist(
                            context,
                            video,
                            widget.playlistid,
                          );
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        addToFavorites(video.videoFile, context, boxFavorite);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => CustomVideoPlayer(
                                      videoPath: video.videoFile,
                                    )));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
