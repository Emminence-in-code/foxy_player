import 'package:flutter/material.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/media_items.dart';
import 'package:provider/provider.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AudioProvider(),
        builder: (context, _) {
          return Consumer<AudioProvider>(builder: (context, audio, _) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<FileProvider>(context, listen: false)
                        .findFiles();
                  },
                  child: Consumer<FileProvider>(
                      builder: (context, fileProvider, _) {
                    final playlist = fileProvider.audioFiles;
                    audio.setPlaylist(playlist);
                    return ListView.builder(
                        itemCount: playlist.length,
                        itemBuilder: (context, index) {
                          final song = playlist[index];

                          return AudioItem(
                            song: song,
                            onTap: () {
                              audio.currentTrack = song;
                              audio.setVisible();

                              audio.playAudio(song.filePath);
                            },
                          );
                        });
                  }),
                ),
                if (audio.visible)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: BottomAudioPlayer(
                      title: audio.currentTrack!.title,
                      onNext: () async {
                        await audio.playNext();
                      },
                      onPlay: () async {
                        await audio.togglePlay();
                      },
                      onPrev: () async {
                        await audio.playPrev();
                      },
                      isPlaying: audio.audioPlayer.playing,
                    ),
                  )
              ],
            );
          });
        });
  }
}
