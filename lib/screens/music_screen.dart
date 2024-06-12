import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/pages/pages.dart';
import 'package:foxy_player/widgets/audio_player.dart';
import 'package:foxy_player/widgets/media_items.dart';
import 'package:foxy_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (context, audio, _) {
      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              Provider.of<FileProvider>(context).findFiles(rebuild: true);
            },
            child: Consumer<FileProvider>(builder: (context, fileProvider, _) {
              final playlist = fileProvider.audioFiles;
              audio.setPlaylist(playlist);
              if (fileProvider.audioFiles.isEmpty) {
                fileProvider.findFiles(rebuild: true);
                audio.setPlaylist(playlist);

                return const EmptyPage(
                    icon: Icon(FontAwesomeIcons.fileAudio),
                    text: Text(
                        'No Audios Yet \n if this persists contact dev team'));
              }

              fileProvider.findFiles();
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
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (builder) {
                    return AudioPlayerPage(
                      song: audio.currentTrack!,
                      audioProvider: audio,
                    );
                  }));
                },
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
              ),
            )
        ],
      );
    });
  }
}
