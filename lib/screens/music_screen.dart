import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/pages/pages.dart';
import 'package:foxy_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioProvider audio = Provider.of<AudioProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<FileProvider>(context).findFiles(rebuild: true);
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
                onTap: () async {
                  audio.currentTrack = song;
                  await audio.playAudio(song.filePath);
                },
              );
            });
      }),
    );
  }
}
