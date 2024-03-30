import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/model.dart';
import 'package:rhythmix/Screens/video/Videoplayer.dart';

import 'package:rhythmix/Thumbnail/thumbnail.dart';
import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';

class Favoritevideos extends StatefulWidget {
  final Box<videofavorite> boxFavorite;

  const Favoritevideos(this.boxFavorite, {super.key});

  @override
  State<Favoritevideos> createState() => _FavoritevideosState();
}

class _FavoritevideosState extends State<Favoritevideos> {
  @override
  Widget build(BuildContext context) {
    final favoriteVideos = widget.boxFavorite.values.toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: myGradient),
        child: favoriteVideos.isEmpty
            ? const Center(
                child: Text('No favorite videos added yet.'),
              )
            : ListView.builder(
                itemCount: favoriteVideos.length,
                itemBuilder: (context, index) {
                  final favoriteVideo = favoriteVideos[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                favoriteVideo.Favoritevideo.split('/').last,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: ValueListenableBuilder<Uint8List?>(
                                valueListenable: generateThumbnailNotifier(
                                    favoriteVideo.Favoritevideo.createPath()),
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
                              onTap: () {
                                // Navigate to the video player screen with the selected favorite video
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => CustomVideoPlayer(
                                      videoPath: favoriteVideo.Favoritevideo,
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  // Delete the favorite video from the box when delete button is pressed
                                  deletefav(index);
                                },
                                icon: const Icon(Icons.favorite,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(), // Add a divider between list items
                    ],
                  );
                },
              ),
      ),
    );
  }

  void deletefav(int index) {
    widget.boxFavorite.deleteAt(index);
    setState(() {});
  }
}
