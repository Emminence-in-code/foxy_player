import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/cirular_animted_container.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:foxy_player/widgets/scrolling_text.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage(
      {super.key, required this.song, required this.audioProvider});
  final Song song;
  final AudioProvider audioProvider;
  @override
  Widget build(BuildContext context) {
    final String uri = song.filePath;
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<Duration?>(
          future: audioProvider.playAudio(uri),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              Navigator.of(context).pop();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // APP BAR
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
                  // SPACING
                  const SizedBox(
                    height: 50,
                  ),
                  // MAIN PAGE
                  NeuBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300,
                          child: RotatingIconContainer(
                            isBig: true,
                            audioPlayer: audioProvider.audioPlayer,
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
                                    text: song.title,
                                  ),
                                  Text('By ${song.artist}'),
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
                  // DURATION DISPLAY
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '0${audioProvider.audioPlayer.position.inMinutes} : ${audioProvider.audioPlayer.position.inMinutes % 60}0'
                                .toString()),
                        const Icon(Icons.shuffle_rounded),
                        const Icon(Icons.repeat_rounded),
                        Text(
                            '0${audioProvider.audioPlayer.duration?.inMinutes} : ${audioProvider.audioPlayer.duration?.inMinutes ?? 100 % 60}0'),
                      ],
                    ),
                  ),
                  // SLIDER STREAM
                  StreamBuilder<Duration?>(
                      stream: audioProvider.audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        double max = audioProvider
                                .audioPlayer.duration?.inSeconds
                                .toDouble() ??
                            100.0;
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return AudioSlider(
                            audioPlayer: audioProvider.audioPlayer,
                            value: double.tryParse('${snapshot.data}'),
                            max: max,
                          );
                        }
                        return AudioSlider(
                          audioPlayer: audioProvider.audioPlayer,
                          value: double.tryParse('${snapshot.data}'),
                          max: max,
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.skip_previous_rounded,
                          size: 50,
                          color: Colors.brown,
                        ),
                      )),
                      const SizedBox(width: 30),
                      PausePlayButton(
                        audioPlayer: audioProvider.audioPlayer,
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: GestureDetector(
                          child: const Icon(
                            Icons.skip_next_rounded,
                            size: 50,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    ));
  }
}
