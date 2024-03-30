import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/model.dart';
import 'package:rhythmix/Videoplaylist/playlistfuntion.dart';

void showDeletePlaylistDialog(BuildContext context, Function onDelete, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Playlist'),
        content: const Text('Are you sure you want to delete this playlist?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print('Delete cancelled');
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print('Deleting playlist');
              onDelete(index);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}


void showAddPlaylistDialog(BuildContext context, Function(String) onAdd) {
  final TextEditingController _textEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Playlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Playlist Name'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String playlistName = _textEditingController.text;
                    if (playlistName.isNotEmpty) {
                      await onAdd(playlistName);
                      _textEditingController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('OK'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


void showAllPlaylistDialog(Videohive videoPath, BuildContext context) async {
  try {
    final playlistBox = Hive.box<VideoPlaylist>('videoplaylistBox');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Playlist'),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: playlistBox.length,
            itemBuilder: (context, index) {
              final playlistid = playlistBox.getAt(index);
              return ListTile(
                title: Text(playlistid!.name),
                onTap: () async {
                  Navigator.pop(context);
                  // Await the addVideoToPlaylist function
                  await addVideoToPlaylist(context, videoPath, playlistid.id);
                },
              );
            },
          ),
        );
      },
    );
  } catch (e) {
    // Handle error gracefully, e.g., show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error showing playlist dialog: $e'),
      ),
    );
  }
}
