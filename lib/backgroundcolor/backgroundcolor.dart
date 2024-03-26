
import 'package:flutter/material.dart';


const LinearGradient myGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(250, 39, 116, 232),
    Color.fromARGB(255, 183, 12, 221)
  ],
);

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(width:double.infinity,
        child: Center(child: Text('ksajdvwshddlhl;wsdk;wdfh'),),
      ),
    );
  }
}
// class FavoriteList extends StatelessWidget {
//   const FavoriteList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(),
//     );
//   }
// }

