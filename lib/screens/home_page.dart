// ignore: file_names
import 'package:flutter/material.dart';
import 'package:rhythmix/appbar/appbar.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/recently_played/recently_played_song/recent_songs_home.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recently_played_videos_screen.dart';
import 'package:rhythmix/recently_played/recently_played_videos/recent_home.dart';
import 'package:rhythmix/screens/song/audio_list.dart';
import 'package:rhythmix/screens/video/video_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          height: 800,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 13,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Recently played Video',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const RecentlyPlayedVideosScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'View More',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildRecentlyPlayedVideos()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: 250,
                  color: const Color.fromARGB(37, 255, 193, 7),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 13,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Recently played Songs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: TextButton(
                                onPressed: () {
                                
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const RecentlyPlayedSongsScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'View More',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      buildRecentlyPlayedSongs()
                    ],
                  ),
                ),
              ),
            ],
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
      } else if (_selectedIndex == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Songs()),
        );
      }
    });
  }
}
