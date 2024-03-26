import 'package:Rhythmix/Database/boxes.dart';
import 'package:Rhythmix/Screens/video/favoriteVideos/addvideostofavorite.dart';
import 'package:Rhythmix/Thumbnail/thumbnail.dart';
import 'package:Rhythmix/backgroundcolor/backgroundcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Rhythmix/Screens/video/Videoplayer.dart';
import '../../Database/openbox.dart';

class Videofunction extends StatefulWidget {
  const Videofunction({Key? key}) : super(key: key);

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
        decoration: const BoxDecoration(gradient: myGradient),
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
                  final video =boxvideo.getAt(index);

                  if (video == null) {
                    return Container();
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CustomVideoPlayer(
                            videoPath: video.videoFile,
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
                                    child: ValueListenableBuilder(
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
                                  Positioned(
                                    top: 10,
                                    child: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
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
                                            // Add to playlist
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
                                            // Share video
                                          },
                                          child: const Text('Share'),
                                        ),
                                      ],
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 130),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 30,
                                          color: Color.fromARGB(255, 163, 163, 163),
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
