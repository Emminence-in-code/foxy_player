import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/pages/pages.dart';
import 'package:foxy_player/services/song.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:provider/provider.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({
    super.key,
    required this.song,
    required this.onTap,
  });
  final Song song;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 15),
        child: Row(
          children: [
            // PLACEHOLDER FOR IMAGE(REPLACE CONTAINER WITH IMAGE)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: CircleAvatar(
                  backgroundColor: Colors.brown.shade200,
                  child: const Icon(Icons.music_note_sharp)),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    ' ${song.title}',
                  ),
                  Text(song.artist)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, required this.videoItem});
  final VideoDetails videoItem;
  @override
  Widget build(BuildContext context) {
    final ThumbnailController thumbnailController =
        ThumbnailController(videoPath: videoItem.videoPath);

    return GestureDetector(
      onTap: () async {
        await Provider.of<AudioProvider>(context, listen: false)
            .audioPlayer
            .stop();
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                VideoPlayerPage(videoPath: videoItem.videoPath),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        child: Row(
          children: [
            // PLACEHOLDER FOR IMAGE(REPLACE CONTAINER WITH IMAGE)
            Container(
              // padding: const EdgeInsets.all(23),
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FutureBuilder(
                  future: thumbnailController.initThumbnail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      String thumbNail = thumbnailController.thumbnailPath;
                      return SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.black,
                              ),
                              File(thumbNail),
                              fit: BoxFit.cover,
                            ),
                          ));
                    }
                    return Container(
                      color: Colors.black,
                    );
                  }),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    ' ${videoItem.videoName}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(videoItem.videoSize),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
