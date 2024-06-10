import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({super.key, required this.videoPath});
  final String videoPath;
  late VideoPlayerController videoPlayerController;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late ChewieController chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.videoPlayerController =
        VideoPlayerController.file(File(widget.videoPath));
    chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        looping: true,
        allowFullScreen: true,
        autoPlay: true);
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.videoPlayerController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (!chewieController.isPlaying) {
              chewieController.play();
            }
            return Chewie(
              controller: chewieController,
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }
}
