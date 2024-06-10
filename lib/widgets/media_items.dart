import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy_player/pages/pages.dart';
import 'package:foxy_player/services/song.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/model/video_model.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({super.key, required this.song, });
  final Song song;

  @override
  Widget build(BuildContext context) {
    bool onGestureClick = false;
    return GestureDetector(
      onTap: () {
        if (!onGestureClick) {
          onGestureClick = true;
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AudioPlayerPage(
              song: song,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        child: Row(
          children: [
            // PLACEHOLDER FOR IMAGE(REPLACE CONTAINER WITH IMAGE)
            Container(
              padding: const EdgeInsets.all(23),
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: CircleAvatar(
                  backgroundColor: Colors.brown.shade500,
                  child: const Icon(Icons.music_note_sharp)),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    ' ${song.title}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(song.artist),
                      Text(
                        onGestureClick == false ? 'NEW' : '',
                        style: const TextStyle(color: Colors.orangeAccent),
                      ),
                    ],
                  )
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
      onTap: () {
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
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FutureBuilder(
                  future: thumbnailController.initThumbnail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Image.file(
                        File(thumbnailController.thumbnailPath),
                        fit: BoxFit.fill,
                      );
                    }
                    return Container();
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
                      const Text(
                        'NEW',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
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
