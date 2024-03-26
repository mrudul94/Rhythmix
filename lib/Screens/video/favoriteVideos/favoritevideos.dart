import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Rhythmix/Database/model.dart';
import 'package:Rhythmix/Screens/video/Videoplayer.dart';
import 'package:Rhythmix/Thumbnail/thumbnail.dart';
import 'package:Rhythmix/backgroundcolor/backgroundcolor.dart';

class Favoritevideos extends StatefulWidget {
  final Box<videofavorite> boxFavorite;

  const Favoritevideos(this.boxFavorite, {Key? key}) : super(key: key);

  @override
  State<Favoritevideos> createState() => _FavoritevideosState();
}

class _FavoritevideosState extends State<Favoritevideos> {
  @override
  Widget build(BuildContext context) {
    final favoriteVideos = widget.boxFavorite.values.toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: myGradient),
        child: favoriteVideos.isEmpty
            ? const Center(
                child: Text('No favorite videos added yet.'),
              )
            : ListView.builder(
                itemCount: favoriteVideos.length,
                itemBuilder: (context, index) {
                  final favoriteVideo = favoriteVideos[index];
                  return ListTile(
                    title: Text(
                      favoriteVideo.Favoritevideo.split('/').last,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: ValueListenableBuilder<Uint8List?>(
                      valueListenable:
                          generateThumbnailNotifier(favoriteVideo.Favoritevideo),
                      builder: (context, thumbnailData, child) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: thumbnailData != null
                              ? Image.memory(
                                  thumbnailData,
                                  fit: BoxFit.cover,
                                )
                              : Container(), // Don't display anything if thumbnailData is null
                        );
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
                        widget.boxFavorite.delete(favoriteVideo.);
                        // Update the UI
                        setState(() {});
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
