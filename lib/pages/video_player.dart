import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';  // Ensure this is imported

class VideoPlayerPage extends StatefulWidget {
  final String videoPath;

  const VideoPlayerPage({super.key, required this.videoPath});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController videoPlayerController; // Correct type declaration
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController
    videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    
    // Initialize the ChewieController
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      customControls: MaterialControls(showPlayButton: true),
      looping: true,
      allowFullScreen: true,
      autoPlay: true,
      fullScreenByDefault: false,
    );
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    videoPlayerController.dispose();
    chewieController.dispose();  // Don't forget to dispose of ChewieController too
    super.dispose();
  }

  Future<void> initializeVideo() async {
    await videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeVideo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Chewie(
            controller: chewieController,
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
