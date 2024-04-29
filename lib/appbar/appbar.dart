import 'package:flutter/material.dart';
import 'package:rhythmix/Screens/song/audio_list.dart';
import 'package:rhythmix/Screens/video/video_list.dart';
import 'package:rhythmix/Settings/privacy_policy.dart';
import 'package:rhythmix/Settings/settings_page.dart';
import 'package:rhythmix/Share/share_app.dart';

AppBar buildCustomAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.black,
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
                  ),
                );
              },
              child: const Text('Go to Video'),
            ),
            PopupMenuItem(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Songs(),
                  ),
                );
              },
              child: const Text('Go to Music'),
            ),
            PopupMenuItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const PrivacyPolicy()));
                },
                child: const Text('Terms and policy')),
            PopupMenuItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const SettingsPage()));
                },
                child: const Text('Settings')),
            PopupMenuItem(
              onTap: () {
                shareApp();
              },
              child: const Text('Share App'),
            ),
          ],
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, size: 30),
          ),
        ),
      )
    ],
  );
}
