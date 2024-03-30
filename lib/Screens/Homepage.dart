import 'package:flutter/material.dart';
import 'package:rhythmix/Screens/song/Audiolist.dart';
import 'package:rhythmix/Screens/video/Videolist.dart';
import 'package:rhythmix/backgroundcolor/backgroundcolor.dart';


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
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Videolist(),
                          ));
                    },
                    child: const Text('Go to Video')),
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Songs(),
                          ));
                    },
                    child: const Text('Go to Music')),
                PopupMenuItem(
                    onTap: () {}, child: const Text('Terms and policy')),
                PopupMenuItem(onTap: () {}, child: const Text('Settings')),
                PopupMenuItem(
                  onTap: () {
                    
  },
                  child: const Text('Share App'),
                ),
              ],
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.more_vert, size: 30, weight: 20),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: myGradient),
          height: 800,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: const Color.fromARGB(59, 7, 23, 255),
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
                                onPressed: () {},
                                child: const Text(
                                  'View More',
                                  style: TextStyle(color: Colors.black),), ), ),],), ),
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('Recently played Video Not Founded'),
                      )],  ), ),),
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
                                },
                                child: const Text(
                                  'View More',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const Center(
                          child: Text('Recently played Songs not founded'))
                    ],
                  ),
                ),
              ),
            ],
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
      if (_selectedIndex == 0) {
        // Navigate to Videolist screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Videolist()),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Songs()));
      }
    });
  }
}
