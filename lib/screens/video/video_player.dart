import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rhythmix/Screens/video/Video_full_screen.dart';
import 'package:rhythmix/screens/video/Video_normal_screen.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath;

  const CustomVideoPlayer({super.key, required this.videoPath});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoController;
  double _sliderValue = 0.0;
  bool _showControls = true;
  bool _isFullScreen = false;
  Timer? _hideControlsTimer;

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
    _hideControlsTimer = Timer(const Duration(seconds: 10), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _hideControlsTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
     
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTapDown: (details) {
                    if (!_isFullScreen) {
           
            // If video is not in fullscreen mode
            if (details.localPosition.dx < screenWidth / 2) {
              // If double tap is on the left half of the screen, seek backward
              _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds - 10));
            } else {
              // If double tap is on the right half of the screen, seek forward
              _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds + 10));
            }
          }
        },
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
          _resetHideControlsTimer();
        },
        child: Center(
          child: _videoController.value.isInitialized
              ? _isFullScreen
                  ? buildFullScreenVideoPlayer(
                      videoController: _videoController,
                      sliderValue: _sliderValue,
                      showControls: _showControls,
                      setIsFullScreen: (bool value) {
                        setState(() {
                          _isFullScreen = value;
                        });
                      },
                      onSliderChanged: (double newValue) {
                        setState(() {
                          _sliderValue = newValue;
                          _videoController.seekTo(Duration(milliseconds: newValue.toInt()));
                        });
                      },
                      onRewind: () {
                        _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds - 10));
                      },
                      onPlayPause: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      },
                      onFastForward: () {
                        _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds + 10));
                      },
                      context: context,
                      videoPath: widget.videoPath,
                    )
                  : buildDefaultVideoPlayer(
                  videoController: _videoController,
                  sliderValue: _sliderValue,
                  showControls: _showControls,
                  setIsFullScreen: (bool value) {
                    setState(() {
                      _isFullScreen = value;
                    });
                  },
                  onSliderChanged: (double newValue) {
                    setState(() {
                      _sliderValue = newValue;
                      _videoController.seekTo(Duration(milliseconds: newValue.toInt()));
                    });
                  },
                  onRewind: () {
                    _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds - 10));
                  },
                  onPlayPause: () {
                    setState(() {
                      if (_videoController.value.isPlaying) {
                        _videoController.pause();
                      } else {
                        _videoController.play();
                      }
                    });
                  },
                  onFastForward: () {
                    _videoController.seekTo(Duration(seconds: _videoController.value.position.inSeconds + 10));
                  },
                  context: context,
                  videoPath: widget.videoPath,
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _resetHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 10), () {
      setState(() {
        _showControls = false;
      });
    });
  }
}
