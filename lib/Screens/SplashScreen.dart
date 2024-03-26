
import 'package:Rhythmix/Database/boxes.dart';
import 'package:Rhythmix/Fletching/videoFetching/dbfunction.dart';
import 'package:Rhythmix/Database/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:Rhythmix/Screens/Homepage.dart';
import 'package:Rhythmix/backgroundcolor/backgroundcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _requestPermissionsAndNavigate();
    initializeData();
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
            gradient: myGradient,
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
    openVideosBox();
    //  if (boxvideo.isEmpty) {
       fetchVideo();
    // }
   }
    Future<void> openVideosBox() async {
    boxvideo = await Hive.openBox<Videohive>('videosBox');
    setState(() {});
  }
}
