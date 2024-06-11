import 'package:flutter/material.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:just_audio/just_audio.dart';

class AudioSlider extends StatelessWidget {
  const AudioSlider({super.key, required this.value});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      value: value == null ? 0.0 : value!,
      activeColor: Colors.brown.shade400,
      inactiveColor: Colors.brown.shade100,
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
      child: Icon(widget.audioPlayer.playing
          ? Icons.pause_circle_rounded
          : Icons.play_arrow_rounded),
    );
  }
}
