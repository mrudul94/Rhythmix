import 'package:Rhythmix/Database/adapter.dart';

import 'package:Rhythmix/Database/openbox.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Screens/SplashScreen.dart';

Future <void> main() async {
  await Hive.initFlutter();
  registerAdapter();
  openBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
