import 'package:flutter/material.dart';
import 'package:rhythmix/screens/home_page.dart';
import 'package:rhythmix/screens/song/audio_functions.dart';
import 'package:rhythmix/Search/song_search.dart';
import 'package:rhythmix/favorite_songs/favorite_songs_screen.dart';
import 'package:rhythmix/screens/video/video_list.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/open_box.dart';
import 'package:rhythmix/song_playlist/song_playlist_home.dart';

class Songs extends StatefulWidget {
  const Songs({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  int _selectedIndex = 2;
  // late OnAudioQuery _audioQuery;

  @override
  void initState() {
    super.initState();
    // _audioQuery = OnAudioQuery();
    openBoxes().then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Image.asset(
          'android/assets/images/Picsart_24-02-29_11-54-16-279.png',
          height: 150,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => const Songsearch()));
            },
            icon: const Icon(Icons.search),
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Songs'),
                    Tab(text: 'Playlist'),
                    Tab(text: 'Favorite'),
                  ],
                  indicatorColor: Colors.red,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                     const AudioFunction(),
                      const SongplaylistHome(),
                      FavoriteSongs(songfavorite),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_file),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Songs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to Videolist screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Videolist()),
        );
      } else if (_selectedIndex == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
    });
  }
}
