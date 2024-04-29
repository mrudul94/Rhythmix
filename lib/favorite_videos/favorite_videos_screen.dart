import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/hive_items/model.dart';

class Favoritevideos extends StatefulWidget {
  final Box<Videofavorite> boxFavorite;

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
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.black),
        child: favoriteVideos.isEmpty
            ? const Center(
                child: Text(
                  'No favorite videos added yet.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: favoriteVideos.length,
                itemBuilder: (context, index) {
                  final favoriteVideo = favoriteVideos[index];
                  return Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              favoriteVideo.favoritevideo.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: ValueListenableBuilder<Uint8List?>(
                              valueListenable: generateThumbnailNotifier(
                                  favoriteVideo.favoritevideo.createPath()),
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
                                    videoPath: favoriteVideo.favoritevideo,
                                  ),
                                ),
                              );
                            },
                            trailing: IconButton(
                              onPressed: () {
                                // Delete the favorite video from the box when delete button is pressed
                                deletefav(index);
                              },
                              icon:
                                  const Icon(Icons.favorite, color: Colors.red),
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
