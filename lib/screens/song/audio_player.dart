import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rhythmix/recently_played/recently_played_song/recently_played_songs_screen.dart';
import 'package:rhythmix/screens/song/audio_functions.dart';
import 'package:rhythmix/favorite_songs/add_to_favorite.dart';
import 'package:rhythmix/hive_items/boxes.dart';
import 'package:rhythmix/hive_items/open_box.dart';

class AudioplayerScreen extends StatefulWidget {
  final String audioPath;
  const AudioplayerScreen({super.key, required this.audioPath});

  @override
  // ignore: library_private_types_in_public_api
  _AudioplayerScreenState createState() => _AudioplayerScreenState();
}

class _AudioplayerScreenState extends State<AudioplayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _loopEnabled = false;
  bool alreadyExists = false;

  @override
  void initState() {
    super.initState();
    openBoxes();
    _initPlayer();
    _togglePlayback(); // Automatically start playing the audio when the page loads
    alreadyExists = songfavorite.values
        .any((element) => element.favoritesong == widget.audioPath);
  }

  Future<void> _initPlayer() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer.setFilePath(widget.audioPath);

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });

      _audioPlayer.playerStateStream.listen((state) {
        setState(() {
          _isPlaying = state.playing;
          _duration = _audioPlayer.duration ?? Duration.zero;
        });
      });

      _audioPlayer.playerStateStream.handleError((error) {});
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  Future<void> _seekTo(double value) async {
    await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  Future<void> _toggleLoop() async {
    await _audioPlayer.setLoopMode(_loopEnabled ? LoopMode.off : LoopMode.one);
    setState(() {
      _loopEnabled = !_loopEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Image.asset(
            'android/assets/images/Picsart_24-02-29_11-54-16-279.png',
            height: 150,
          ),
        ),
        
        backgroundColor: const Color.fromARGB(249, 12, 79, 181),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(249, 12, 79, 181),
                Color.fromARGB(255, 183, 12, 221),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 548,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: CircleAvatar(
                        maxRadius: 100,
                        backgroundColor: Colors.black,
                        child: Image.asset(
                            'android/assets/images/Picsart_24-02-29_11-54-16-279.png'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 120, left: 50, right: 50),
                      child: Text(
                        widget.audioPath.split('/').last,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Slider(
                            min: 0.0,
                            max: _duration.inMilliseconds.toDouble(),
                            value: _position.inMilliseconds.toDouble().clamp(
                                  0.0,
                                  _duration.inMilliseconds.toDouble(),
                                ),
                            onChanged: (value) {
                              _seekTo(value);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _toggleLoop,
                                icon: Icon(
                                  Icons.loop,
                                  color:
                                      _loopEnabled ? Colors.red : Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  onSkipPrevioussong(context, widget.audioPath);
                                },
                                icon: const Icon(Icons.skip_previous,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: _togglePlayback,
                                icon: _isPlaying
                                    ? const Icon(Icons.pause,
                                        color: Colors.white)
                                    : const Icon(Icons.play_arrow,
                                        color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  int currentIndex =
                                      songbox.values.toList().indexWhere(
                                          // ignore: unrelated_type_equality_checks
                                          (song) => song.songfile == song);
                                  if (currentIndex < songbox.length - 1) {
                                    String nextsongPath = songbox
                                            .getAt(currentIndex + 1)
                                            ?.songfile ??
                                        '';
                                    if (nextsongPath.isNotEmpty) {
                                      addToRecentlyPlayedSong(nextsongPath);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => AudioplayerScreen(
                                                audioPath: nextsongPath)),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.skip_next,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (alreadyExists) {
                                    deleteFavorite(context, widget.audioPath);
                                    setState(() {});
                                  } else {
                                    addsongToFavorites(
                                      widget.audioPath,
                                      context,
                                      songfavorite,
                                    );
                                  }
                                  setState(() {
                                    alreadyExists = !alreadyExists;
                                  });
                                },
                                icon: alreadyExists
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(Icons.favorite_border,
                                        color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
