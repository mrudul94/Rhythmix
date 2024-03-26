import 'package:Rhythmix/Database/model.dart';
import 'package:Rhythmix/Database/openbox.dart';
import 'package:Rhythmix/Screens/song/Audiolist.dart';
import 'package:Rhythmix/Screens/Homepage.dart';
import 'package:Rhythmix/Screens/video/VideoFunction.dart';
import 'package:Rhythmix/Screens/video/favoriteVideos/favoritevideos.dart';
import 'package:Rhythmix/backgroundcolor/backgroundcolor.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Videolist extends StatefulWidget {
  const Videolist({Key? key}) : super(key: key);

  @override
  State<Videolist> createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  int _selectedIndex = 0;
  late Box<videofavorite> boxFavorite;
  @override
  void initState() {
    super.initState();
    // Call openBoxes() to initialize the boxes
    openBoxes();
    boxFavorite = Hive.box<videofavorite>('Favoriteboc');
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
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: myGradient,
        ),
        child: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Column(
              children: [
                TabBar(tabs: [
                  Tab(
                    text: 'Videos',
                  ),
                  Tab(
                    text: 'Playlist',
                  ),
                  Tab(
                    text: 'Favorite',
                  )
                ]),
                Expanded(child: TabBarView(children: 
                [
                  Videofunction(),
                  PlayList(),
                  Favoritevideos(boxFavorite),
                ]))
              ],
            ),
          ),
        ),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // Navigate to Videolist screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Songs()));
      }
    });
  }
}
