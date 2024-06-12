import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RotatingIconContainer extends StatefulWidget {
  const RotatingIconContainer(
      {super.key, required this.audioPlayer, required this.isBig});
  final AudioPlayer audioPlayer;
  final bool isBig;
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
        width: widget.isBig ? 200.0 : 50,
        height: widget.isBig ? 200.0 : 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown.shade200,
        ),
        child: Center(
          child: Icon(
            Icons.music_note,
            color: Colors.white,
            size: widget.isBig ? 80 : 20,
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
