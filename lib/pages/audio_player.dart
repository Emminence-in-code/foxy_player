import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/widgets/neu_box.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  int currentSongIndex;
  bool isPlaying = false;
  AudioPlayerPage({super.key, required this.currentSongIndex});

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();

    return Consumer<FileProvider>(builder: (context, fileProvider, child)  {
      final currentSong = fileProvider.audioFiles[currentSongIndex];
      try {audioPlayer.stop();
        audioPlayer.setUrl(currentSong.filePath);
        
      audioPlayer.play();
      isPlaying = true;
      } on Exception{
        print('Error, Cannot Load song');
      }
     

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
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentSong.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('By ${currentSong.artist}'),
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                Slider(
                  min: 0,
                  max: 100,
                  value: 50,
                  activeColor: Colors.brown.shade400,
                  inactiveColor: Colors.brown.shade100,
                  onChanged: ((value) {}),
                ),
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
                          child: NeuBox(
                              child: const Icon(Icons.play_arrow_rounded)),
                        )),
                    const SizedBox(width: 30),
                    Expanded(
                        child: GestureDetector(
                            child: NeuBox(
                                child: const Icon(Icons.skip_next_rounded)))),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
