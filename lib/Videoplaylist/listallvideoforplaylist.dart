// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhythmix/Database/boxes.dart';
import 'package:rhythmix/Videoplaylist/playlistfuntion.dart';
import 'package:rhythmix/Thumbnail/thumbnail.dart';
import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';

class LisstallVideo extends StatefulWidget {
  const LisstallVideo({Key? key}) : super(key: key);

  @override
  State<LisstallVideo> createState() => _LisstallVideoState();
}

class _LisstallVideoState extends State<LisstallVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Videos'),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: myGradient),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: boxvideo.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final video = boxvideo.getAt(index);

                  if (video == null) {
                    return Container();
                  }

                  return ListTile(
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
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final playlists = await getvideo(); 
                        if (playlists.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select Playlist'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: playlists.length,
                                    itemBuilder: (context, index) {
                                      final playlist = playlists[index];
                                      return ListTile(
                                        title: Text(playlist.name),
                                        onTap: () {
                                         
                                          setState(() {
                                             addVideoToPlaylist(context, video, playlist.id);
                                             Navigator.pop(context);
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('No Playlists'),
                                content: const Text(
                                    'There are no playlists available. Please create a playlist first.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
