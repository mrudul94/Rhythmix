import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rhythmix/fletching/song_fetching/song_fetching.dart';
import 'package:rhythmix/fletching/video_fetching/video_fetching.dart';
import 'package:rhythmix/screens/home_page.dart';
import 'package:rhythmix/hive_items/open_box.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()  {
    super.initState();
      _initializeData();
  }

  Future<void> _initializeData() async {
   await _requestPermissionsAndNavigate();
    await initializeData();
  }
  Future<void> _requestPermissionsAndNavigate() async {
    // Request permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.mediaLibrary,
      // Add other permissions you need here
    ].request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      // Permissions granted, navigate to home screen
      
      // ignore: use_build_context_synchronously
      gotoHomeScreen(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Image.asset(
              'android/assets/images/Picsart_24-02-29_11-54-16-279.png'),
        ),
      ),
    );
  }

  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 8));

    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const Homepage()));
  }
  
   Future<void> initializeData() async {
    await openBoxes();
    await fetchVideo();
    await fetchAndAddSongsToHive();
     setState(() {
       
     });
   
     
   }
    

}
