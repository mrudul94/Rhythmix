// audio_functions.dart
import 'package:Rhythmix/Screens/song/Audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget audioFunction(BuildContext context) {
  return FutureBuilder<List<SongModel>>(
    future: OnAudioQuery().querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    ),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
        return const Text("Nothing found!");
      } else {
        return ListView.builder(
          itemCount: snapshot.data!.length * 2 - 1,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return const Divider(color: Colors.black);
            } else {
              final itemIndex = index ~/ 2;
              return ListTile(
                title: Text(
                  snapshot.data![itemIndex].title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(snapshot.data![itemIndex].artist ?? "No Artist"),
                leading: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.music_note)),
                trailing: SizedBox(
                  width: 24,
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioplayerScreen(
                                  audioPath: snapshot.data![itemIndex].data,
                                ),
                              ),
                            );
                          },
                          child: const Text('Play')),
                      PopupMenuItem(
                          onTap: () {}, child: const Text('Add to Playlist')),
                      PopupMenuItem(
                          onTap: () {}, child: const Text('Favorite')),
                      PopupMenuItem(onTap: () {}, child: const Text('Share')),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.more_vert, size: 30, weight: 20),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioplayerScreen(
                        audioPath: snapshot.data![itemIndex].data,
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      }
    },
  );
}
