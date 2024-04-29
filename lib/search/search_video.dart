import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/Screens/video/video_player.dart';
import 'package:rhythmix/Share/share_video.dart';
import 'package:rhythmix/Thumbnail/thumbnail_generator.dart';
import 'package:rhythmix/favorite_videos/add_videos_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/showdialoges/show_dialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  List<Videohive> _filteredVideos = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredVideos = boxvideo.values.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVideos(String query) {
    setState(() {
      _filteredVideos = boxvideo.values.where((video) {
        final videoName = video.videoFile.split('/').last.toLowerCase();
        return videoName.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Search Screen',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        )),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search for videos...',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: _filterVideos,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredVideos.length,
                itemBuilder: (context, index) {
                  final video = _filteredVideos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CustomVideoPlayer(
                                  videoPath: video.videoFile,
                                ),
                              ),
                            );
                            setState(() {
                              addToRecentlyPlayed(video.videoFile);
                            });
                          },
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
                                      color: Colors.white,
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
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
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
                                  showAllPlaylistDialog(video, context);
                                },
                                child: const Text('Add to Playlist'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  addToFavorites(
                                      video.videoFile, context, boxFavorite);
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
                            child: const Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 2,
                          color: Colors.white,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
