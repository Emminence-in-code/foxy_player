import 'package:flutter/material.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/widgets/media_items.dart';
import 'package:provider/provider.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<FileProvider>(context, listen: false).findFiles();
      },
      child: Consumer<FileProvider>(builder: (context, fileProvider, _) {
        final playlist = fileProvider.audioFiles;
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final song = playlist[index];
              return AudioItem(
                song: song,
              );
            });
      }),
    );
  }
}
