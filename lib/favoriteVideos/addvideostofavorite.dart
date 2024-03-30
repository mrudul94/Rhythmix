import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:rhythmix/Database/model.dart';

void addToFavorites(String videoPath, BuildContext context, Box boxFavorite) {
  // Dismiss any existing SnackBars
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  // Check if the video is already in favorites
  if (!boxFavorite.values.any((element) => element.Favoritevideo == videoPath)) {
    // If not in favorites, add it
    boxFavorite.add(videofavorite(Favoritevideo: videoPath));
    // Show a Snackbar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Successfully added the video to favorites.'),
      ),
    );
  } else {
    // If already in favorites, show a Snackbar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('This video is already in favorites'),
      ),
    );
  }
}
// void addToplaylist(String videoPath, BuildContext context, playlistBox ) {
//   // Dismiss any existing SnackBars
//   ScaffoldMessenger.of(context).removeCurrentSnackBar();

//   // Check if the video is already in favorites
//   if (!playlistBox.values.any((element) => element.Playlist == videoPath)) {
//     // If not in favorites, add it
//     playlistBox.add(videofavorite(Favoritevideo: videoPath));
//     // Show a Snackbar immediately
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Successfully added the video to favorites.'),
//       ),
//     );
//   } else {
//     // If already in favorites, show a Snackbar immediately
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('This video is already in favorites'),
//       ),
//     );
//   }
// }


// void addTovideoplaylist(String videoPath, BuildContext context, Box boxVideoPlaylist) {
//   // Dismiss any existing SnackBars
//   ScaffoldMessenger.of(context).removeCurrentSnackBar();

//   // Check if the video is already in favorites
//   if (!boxVideoPlaylist.values.any((element) => element.playlistVideo == videoPath)) {
//     // If not in favorites, add it
//     boxVideoPlaylist.add(Videoplaylistbox(Videoplaylistboxes: videoPath));print('${videoPath}00000000000000');
//     // Show a Snackbar immediately
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Successfully added the video to favorites.'),
//       ),
//     );
//   } else {
//     // If already in favorites, show a Snackbar immediately
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('This video is already in favorites'),
//       ),
//     );
//   }
// }