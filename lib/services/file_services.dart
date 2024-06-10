import 'dart:convert';
import 'dart:io';
import 'package:foxy_player/services/song.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:list_all_videos/list_all_videos.dart';

Future<List<VideoDetails>> getVideoFiles() async {
  List<VideoDetails> videoFiles = [];
  ListAllVideos listVideos = ListAllVideos();
  List<VideoDetails> videos = await listVideos.getAllVideosPath();
  videoFiles = videos;
  return videoFiles;
}

class Audio {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<List<Song>> getAudios() async {
    List<Song> songs = [];
    // Get a list of all songs on the device.
    var allSongs = await _audioQuery.querySongs();

    // Convert the list of SongInfo objects to a list of Song objects.
    for (var songInfo in allSongs) {
      // String? songPath = (await _audioQuery.querySongs(
      //         sortType: SongSortType.DISPLAY_NAME,
      //         orderType: OrderType.ASC_OR_SMALLER,
      //         uriType: UriType.INTERNAL,
      //         ignoreCase: true))[0]
      //     .uri;

      songs.add(
        Song(
          title: songInfo.title,
          artist: songInfo.artist!,
          album: songInfo.album!,
          filePath: songInfo.uri!,
        ),
      );
    }
    return songs;
  }
}

Future<List<FileSystemEntity>> getCacheFiles() async {
  List<FileSystemEntity> cacheFiles = [];
  //await handleDirectory();
  return cacheFiles;
}

Future<void> writeCache(Map<String, dynamic> data, String path) async {
  // await handleDirectory();
  final serializedData = jsonEncode(data);
  File cacheFile = File(path);
  if (!cacheFile.existsSync()) {
    cacheFile = await cacheFile.create(recursive: true);
  }
  cacheFile.writeAsString(serializedData, encoding: const Latin1Codec());
}

Future<bool> hasFilePermissions() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  return status.isGranted;
}
