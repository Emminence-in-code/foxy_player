import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RotatingIconContainer extends StatefulWidget {
  const RotatingIconContainer({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  _RotatingIconContainerState createState() => _RotatingIconContainerState();
}

class _RotatingIconContainerState extends State<RotatingIconContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Stream audioStream;
  final StreamController streamController = StreamController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    audioStream = widget.audioPlayer.playingStream;
    audioStream.listen((event) {
      if (event) {
        // _controller.reset();
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
    streamController.addStream(audioStream);
  }

  @override
  void dispose() async {
    super.dispose();
    await streamController.close();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown,
        ),
        child: const Center(
          child: Icon(
            Icons.music_note,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.141592653589793,
          child: child,
        );
      },
    );
  }
}
