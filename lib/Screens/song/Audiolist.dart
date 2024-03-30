import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/Screens/Homepage.dart';
import 'package:rhythmix/Screens/song/AudioFunctions.dart';
import 'package:rhythmix/favoriteSongs/favoritesongs.dart';

import 'package:rhythmix/Screens/video/Videolist.dart';

import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';
// ignore: unused_import
import 'Audioplayer.dart'; 

class Songs extends StatefulWidget {
  const Songs({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  int _selectedIndex = 2;
  // ignore: unused_field
  late OnAudioQuery _audioQuery;

  @override
  void initState() {
    super.initState();
    _audioQuery = OnAudioQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 27, 120, 219),
        elevation: 0.0,
        title: Image.asset(
          'android/assets/images/Picsart_24-02-29_11-54-16-279.png',
          height: 150,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 27, 120, 219),
        child: DefaultTabController(
            length: 3,
            child: SafeArea(
                child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    text: 'Songs',
                  ),
                  Tab(
                    text: 'Playlist',
                  ),
                  Tab(
                    text: 'Favorite',
                  )
                ], indicatorColor: Colors.black),
                Expanded(
                    child: TabBarView(children: [
                  _buildSongList(),
                  const PlayList(),
                  const FavoriteSongs(),
                ]))
              ],
            ))),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 183, 12, 221),
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSongList() {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(250, 39, 116, 232),
              Color.fromARGB(255, 183, 12, 221)
            ],
          ),
        ),
        child: audioFunction(context));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to Videolist screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Videolist()),
        );
      } else if (_selectedIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Homepage()));
      }
    });
  }
}
