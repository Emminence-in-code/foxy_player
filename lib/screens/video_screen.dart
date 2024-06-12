import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FileProvider fileProvider =
        Provider.of<FileProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {},
      child: Consumer<FileProvider>(builder: (context, fileProvider, _) {
        if (fileProvider.videoFiles.isEmpty) {
          fileProvider.findFiles(rebuild: true);

          return const EmptyPage(
              icon: Icon(FontAwesomeIcons.video),
              text: Text('No Videos Yet \n if this persists contact dev team'));
        }
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
