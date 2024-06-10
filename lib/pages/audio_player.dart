import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  final Song song;
  bool isPlaying = false;
  AudioPlayerPage({super.key, required this.song});

  final AudioPlayer audioPlayer = AudioPlayer();
  late Duration? duration;

  // void getDuration() {
  //   try {

  //         .then((value) => duration = value);
  //     audioPlayer.play();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(song.filePath))),
        builder: (context, snapshot) {
          return Consumer<FileProvider>(
              builder: (context, fileProvider, child) {
            // getDuration();
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(FontAwesomeIcons.arrowLeft)),
                          const Text(
                            'Foxy Song',
                            style: TextStyle(letterSpacing: 3, fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.menu))
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      NeuBox(
                        child: Column(
                          children: [
                            Container(
                              height: 350,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'currentSong title',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('By currentSong.artist'),
                                    ],
                                  ),
                                ),
                                Icon(
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
                            print(snapshot.data);
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
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
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () async {
                                  await audioPlayer.play();
                                },
                                child: NeuBox(
                                  child: const Icon(Icons.play_arrow_rounded),
                                ),
                              )),
                          const SizedBox(width: 30),
                          Expanded(
                              child: GestureDetector(
                                  child: NeuBox(
                                      child: const Icon(
                                          Icons.skip_next_rounded)))),
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
