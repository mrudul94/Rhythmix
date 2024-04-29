import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/song_playlist/song_playlist_screen.dart';
import 'package:rhythmix/hive_items/model.dart';

Future<void> addsongToPlaylist(
    BuildContext context, SongModel song, int playlistId) async {
  try {
    final songPlaylistBox = Hive.box<Songplaylist>('songplaylist');
    // ignore: unnecessary_null_comparison
    if (songPlaylistBox == null) {
      // Handle case where songPlaylistBox is null
      return;
    }

    final playlist = songPlaylistBox.get(playlistId);
    if (playlist == null) {
      // Handle case where playlist is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Playlist not found.'),
        ),
      );
      return;
    }

    List<dynamic> temp = playlist.songs ?? [];

    if (temp.contains(song.data)) {
      // Video is already in the playlist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('This video is already in the playlist.'),
        ),
      );
      return;
    }

    temp.add(song
        .data); // Assuming song.data contains the video file path or identifier

    final data =
        Songplaylist(songpath: playlist.songpath, id: playlist.id, songs: temp);
    songPlaylistBox.put(data.id, data);

    // Navigate to the PlaylistSongsPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistSongsPage(
          playlistid: data.id,
          playlistName: playlist.songpath,
          songs: playlist.songs?.cast<String>() ?? [],
        ),
      ),
    );

    // Optionally, you can show a success message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Video added to playlist.'),
      ),
    );
  } catch (e) {
    // Handle error gracefully, e.g., show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding video to playlist: $e'),
      ),
    );
  }
}
