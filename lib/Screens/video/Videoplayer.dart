import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath;

  const CustomVideoPlayer({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoController;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _videoController = VideoPlayerController.network(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.addListener(() {
          setState(() {
            _sliderValue = _videoController.value.position.inMilliseconds.toDouble();
          });
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 87),
        child: Column(
          children: [
            Center(
              child: _videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: Column(
                        children: [
                          Expanded(
                            child: VideoPlayer(_videoController),
                          ),
                          Slider(
                            value: _sliderValue,
                            min: 0,
                            max: _videoController.value.duration.inMilliseconds.toDouble(),
                            onChanged: (newValue) {
                              setState(() {
                                _sliderValue = newValue;
                                _videoController.seekTo(Duration(milliseconds: newValue.toInt()));
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    // Seek 10 seconds backward
                    _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds - 10));
                  },
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    setState(() {
                      // If the video is playing, pause it.
                      if (_videoController.value.isPlaying) {
                        _videoController.pause();
                      } else {
                        // If the video is paused, play it.
                        _videoController.play();
                      }
                    });
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(
                    _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Seek 10 seconds forward
                    _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds + 10));
                  },
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
