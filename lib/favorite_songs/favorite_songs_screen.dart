import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Screens/song/audio_player.dart';
import 'package:rhythmix/hive_items/model.dart';

class FavoriteSongs extends StatefulWidget {
  final Box<FavoriteSong> boxFavorite;

  const FavoriteSongs(this.boxFavorite, {super.key});

  @override
  State<FavoriteSongs> createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  @override
  Widget build(BuildContext context) {
    final favoriteSongs = widget.boxFavorite.values.toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: favoriteSongs.isEmpty
            ? const Center(
                child: Text(
                  'No favorite songs added yet.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: favoriteSongs.length,
                itemBuilder: (context, index) {
                  final favoriteSong = favoriteSongs[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                favoriteSong.favoritesong.split('/').last,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.black,
                                child:
                                    Icon(Icons.music_note, color: Colors.white),
                              ),
                              onTap: () {
                                // Navigate to the audio player screen with the selected favorite song
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => AudioplayerScreen(
                                      audioPath: favoriteSong.favoritesong,
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  // Delete the favorite song from the box when delete button is pressed
                                  deleteFavorite(index);
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

  void deleteFavorite(int index) {
    widget.boxFavorite.deleteAt(index);
    setState(() {});
  }
}
