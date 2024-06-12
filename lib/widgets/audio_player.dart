import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/widgets/cirular_animted_container.dart';
import 'package:foxy_player/widgets/scrolling_text.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioSlider extends StatelessWidget {
  const AudioSlider(
      {super.key,
      required this.value,
      required this.max,
      required this.audioPlayer});
  final double? value;
  final double max;
  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      value: value == null ? 0.0 : value!,
      activeColor: Colors.brown.shade400,
      inactiveColor: Colors.brown.shade200,
      onChanged: ((value) {}),
    );
  }
}

class PausePlayButton extends StatefulWidget {
  const PausePlayButton({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  State<PausePlayButton> createState() => _PausePlayButtonState();
}

class _PausePlayButtonState extends State<PausePlayButton> {
  Future<void> togglePlay() async {
    if (widget.audioPlayer.playing) {
      await widget.audioPlayer.pause();
    } else {
      await widget.audioPlayer.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          togglePlay();
        });
      },
      child: Icon(
          size: 30,
          color: Colors.brown,
          widget.audioPlayer.playing
              ? Icons.pause_circle_rounded
              : Icons.play_arrow_rounded),
    );
  }
}

class BottomAudioPlayer extends StatelessWidget {
  const BottomAudioPlayer(
      {super.key,
      required this.onPlay,
      required this.onPrev,
      required this.onNext,
      required this.title,
      required this.isPlaying});
  final Future Function() onPlay;
  final Future Function() onPrev;
  final Future Function() onNext;
  final String title;
  final bool isPlaying;
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (context, audio, _) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 10),
        height: 65,
        color: Colors.brown.shade100,
        child: Row(children: [
          RotatingIconContainer(audioPlayer: audio.audioPlayer, isBig: false),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ScrollingText(text: title),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    playerButton(
                        onTap: () async {
                          await onPrev.call();
                        },
                        icon: Icons.skip_previous_rounded),
                    const SizedBox(
                      width: 30,
                    ),
                    StreamBuilder(
                        stream: audio.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return playerButton(
                                onTap: () async {
                                  await onPlay.call();
                                },
                                icon: snapshot.data == true
                                    ? Icons.pause
                                    : Icons.play_arrow);
                          }
                          return Container();
                        }),
                    const SizedBox(
                      width: 30,
                    ),
                    playerButton(
                        onTap: () async {
                          await onNext.call();
                        },
                        icon: Icons.skip_next_rounded),
                  ],
                )
              ],
            ),
          )
        ]),
      );
    });
  }
}

Widget playerButton({required Function() onTap, required IconData icon}) {
  return GestureDetector(
    onTap: onTap,
    child: Icon(icon),
  );
}
