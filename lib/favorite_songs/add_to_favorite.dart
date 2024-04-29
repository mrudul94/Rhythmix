import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/model.dart';

void addsongToFavorites(
    String songPath, BuildContext context, Box<FavoriteSong> songfavorite) {
  // Dismiss any existing SnackBars
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  // Check if the song is already in favorites
  if (!songfavorite.values.any((element) => element.favoritesong == songPath)) {
    // If not in favorites, add it
    songfavorite.add(FavoriteSong(favoritesong: songPath));

    // Show a Snackbar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Successfully added the song to favorites.'),
      ),
    );
  } else {
    // If already in favorites, show a Snackbar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('This song is already in favorites'),
      ),
    );
  }
}

void showDeleteSnackbar(BuildContext context, String deletedItem) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Deleted from favorites'),
      backgroundColor: Colors.red,
    ),
  );
}

void deleteFavorite(BuildContext context, String audioPath) {
  final index = songfavorite.values
      .toList()
      .indexWhere((element) => element.favoritesong == audioPath);
  if (index != -1) {
    final deletedItem = songfavorite.values.elementAt(index);
    songfavorite.deleteAt(index);
    showDeleteSnackbar(context, deletedItem.favoritesong);
    // Update the UI if needed
    // setState(() {});
  }
}
