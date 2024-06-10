import 'package:flutter/material.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/widgets/media_items.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FileProvider fileProvider =
        Provider.of<FileProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        await fileProvider.readFiles();
        await fileProvider.findFiles();
      },
      child: Consumer<FileProvider>(builder: (context, fileProvider, _) {
        return ListView.builder(
            itemCount: fileProvider.videoFiles.length,
            itemBuilder: (BuildContext context, index) {
              final videoItem = fileProvider.videoFiles[index];
              return VideoItem(
                videoItem: videoItem,
              );
            });
      }),
    );
  }
}
