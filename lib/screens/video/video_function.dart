import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Share/share_video.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/open_box.dart';
import 'package:rhythmix/showdialoges/show_dialog.dart';

class Videofunction extends StatefulWidget {
  const Videofunction({super.key});

  @override
  State<Videofunction> createState() => _VideofunctionState();
}

class _VideofunctionState extends State<Videofunction> {
   

  @override
  void initState() {
    super.initState();
    openBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  final video =boxvideo.getAt(boxvideo.length - 1 - index);

                  if (video == null) {
                    return Container();
                  }

                  return GestureDetector(
                    onTap: () {
                      addToRecentlyPlayed(video.videoFile);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CustomVideoPlayer(
                            videoPath: video.videoFile,
                          ),
                        ),
                      );
                       addToRecentlyPlayed(video.videoFile);
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
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 120,
                                   width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ValueListenableBuilder<Uint8List?>(
                                        valueListenable: generateThumbnailNotifier(video.videoFile.createPath()),
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
                                  ),
                                  Positioned(
                                    top: 10,right: 5,
                                    child: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            addToRecentlyPlayed(video.videoFile);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) => CustomVideoPlayer(
                                                  videoPath: video.videoFile,
                                                ),
                                              ),
                                              
                                            );
                                          },
                                          child: const Text('Play'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            showAllPlaylistDialog(video,context);
                                          },
                                          child: const Text('Add to Playlist'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            
                                            addToFavorites(video.videoFile,context,boxFavorite);
                                          },
                                          child: const Text('Add to Favorite'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                           shareVideo(video.videoFile);
                                          },
                                          child: const Text('Share'),
                                        ),
                                      ],
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 130),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 30,
                                          color: Colors.white,
                                        ),
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
                              video.videoFile.split('/').last,
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
                itemCount: boxvideo.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

}



