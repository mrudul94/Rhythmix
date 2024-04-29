import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/fletching/song_fetching/song_fetching.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/screens/song/audio_player.dart';
import 'package:rhythmix/song_playlist/add_song_playlist.dart';

class Listallsongsforplaylist extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final playlistid;
  // ignore: use_key_in_widget_constructors
  const Listallsongsforplaylist({Key? key, required this.playlistid});

  @override
  State<Listallsongsforplaylist> createState() =>
      _ListallsongsforplaylistState();
}

class _ListallsongsforplaylistState extends State<Listallsongsforplaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of All Songs'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: FutureBuilder<List<SongModel>>(
              future: fetchAndAddSongsToHive(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Text("Nothing found!");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length * 2 - 1,
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        return const Divider(color: Colors.white);
                      } else {
                        final itemIndex = index ~/ 2;
                        final song = snapshot.data![itemIndex];
                        return ListTile(
                          title: Text(
                            song.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.music_note,
                                color: Colors.black,
                              )),
                          trailing: IconButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await addsongToPlaylist(
                                    context, song, widget.playlistid);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                          onTap: () {
                            addToRecentlyPlayedSong(song.data);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => AudioplayerScreen(
                                        audioPath: song.data)));
                          },
                        );
                      }
                    },
                  );
                }
              },
            )),
      ),
    );
  }
}
