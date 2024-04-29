
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/screens/home_page.dart';
import 'package:rhythmix/screens/song/audio_list.dart';
import 'package:rhythmix/screens/video/video_function.dart';
import 'package:rhythmix/Videoplaylist/video_playlist_home.dart';
import 'package:rhythmix/favorite_videos/favorite_videos_screen.dart';
import 'package:rhythmix/hive_items/model.dart';
import 'package:rhythmix/hive_items/open_box.dart';
import 'package:rhythmix/search/search_video.dart';

class Videolist extends StatefulWidget {
  const Videolist({super.key});

  @override
  State<Videolist> createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  int _selectedIndex = 0;
  late Box<Videofavorite> boxFavorite;

  @override
  void initState() {
    super.initState();
    // Call openBoxes() to initialize the boxes
    openBoxes();
    boxFavorite = Hive.box<Videofavorite>('Favoriteboc');
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
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const SearchScreen()));
              },
              icon: const Icon(Icons.search),
              iconSize: 30,
            ),
          ),
          
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: Colors.red,
                  tabs: [
                    Tab(
                      text: 'Videos',
                    ),
                    Tab(
                      text: 'Playlist',
                    ),
                    Tab(
                      text: 'Favorite',
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
                        ),
                        child: const Videofunction(),
                      ),
                      const VideoPlayLists(),
                      Favoritevideos(boxFavorite),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_file,),
            label: 'Vidoes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music,),
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
      if (_selectedIndex == 1) {
        // Navigate to Videolist screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else if (_selectedIndex == 2) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Songs()));
      }
    });
  }
}