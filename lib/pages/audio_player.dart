import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/cirular_animted_container.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:foxy_player/widgets/scrolling_text.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatefulWidget {
  final Song song;

  const AudioPlayerPage({super.key, required this.song});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    audioPlayer.durationStream.listen((event) {
      print('${event!.inSeconds} seconds from stream');
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await audioPlayer.dispose();
  }

  Future<void> togglePlay() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration?>(
        future: audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(widget.song.filePath))),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return Consumer<FileProvider>(
              builder: (context, fileProvider, child) {
            audioPlayer.play();
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(FontAwesomeIcons.arrowLeft)),
                          const SizedBox(
                            width: 70,
                          ),
                          const Text(
                            'Foxy Song',
                            style: TextStyle(letterSpacing: 3, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      NeuBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 350,
                              child: RotatingIconContainer(
                                audioPlayer: audioPlayer,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ScrollingText(
                                        text: widget.song.title,
                                      ),
                                      Text('By ${widget.song.artist}'),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('00:00'),
                            Icon(Icons.shuffle_rounded),
                            Icon(Icons.repeat_rounded),
                            Text('00:00'),
                          ],
                        ),
                      ),
                      StreamBuilder<int?>(
                          stream: audioPlayer.currentIndexStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              print("${snapshot.data} built");

                              return AudioSlider(
                                  value: double.tryParse('${snapshot.data}'));
                            }
                            return AudioSlider(
                                value: double.tryParse('${snapshot.data}'));
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            child: NeuBox(
                                child: const Icon(Icons.skip_previous_rounded)),
                          )),
                          const SizedBox(width: 30),
                          PausePlayButton(
                            audioPlayer: audioPlayer,
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: GestureDetector(
                              child: NeuBox(
                                child: const Icon(Icons.skip_next_rounded),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
