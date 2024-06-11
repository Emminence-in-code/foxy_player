import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/cirular_animted_container.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:foxy_player/widgets/scrolling_text.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AudioProvider>(builder: (context, audioProvider, _) {
        final String uri = song.filePath;

        return SafeArea(
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
                return Column(
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
                      height: 80,
                    ),
                    // MAIN PAGE
                    NeuBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 350,
                            child: RotatingIconContainer(
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
                    // SLIDER STREAM
                    StreamBuilder<Duration?>(
                        stream: audioProvider.audioPlayer.positionStream,
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
                          audioPlayer: audioProvider.audioPlayer,
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
                );
              }),
        );
      }),
    );
  }
}
