import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/hive_items/adapter.dart';
import 'package:rhythmix/hive_items/open_box.dart';
import 'Screens/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  registerAdapter();
  openBoxes();
  runApp(const Rhythmix());
}

class Rhythmix extends StatelessWidget {
  const Rhythmix({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
