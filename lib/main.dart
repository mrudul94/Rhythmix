import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/Database/adapter.dart';
import 'package:rhythmix/Database/openbox.dart';

import 'Screens/SplashScreen.dart';

Future <void> main() async {
  await Hive.initFlutter();
  registerAdapter();
  openBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
