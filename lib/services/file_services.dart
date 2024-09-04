import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foxy_player/config/config.dart';
import 'package:foxy_player/services/album.dart';
import 'package:foxy_player/services/song.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
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
    final hasperm = _audioQuery.permissionsRequest();
    if (await hasperm) {
      List<Song> songs = [];

      // Get a list of all songs on the device.
    

      var allSongs = await _audioQuery.querySongs();

      // Convert the list of SongInfo objects to a list of Song objects.
      for (var songInfo in allSongs) {
        final artWork = await _audioQuery.queryArtwork(
          songInfo.id,
          ArtworkType.AUDIO,
        );
        songs.add(
          Song(
            image: artWork!,
            title: songInfo.title,
            artist: songInfo.artist!,
            album: songInfo.album!,
            filePath: songInfo.uri!,
          ),
        );
      }
      return songs;
    }
    return [];
  }

  Future<List<Album>> getAudioAlbums() async {
    final hasperm = _audioQuery.permissionsRequest();
    if (await hasperm) {
      List<Album> albums = [];

      // Get a list of all songs on the device.
      var allAlbums = await _audioQuery.queryAlbums();
      for (var newAlbum in allAlbums) {
        String name = newAlbum.album;

        final artWork = await _audioQuery.queryArtwork(
          newAlbum.id,
          ArtworkType.ALBUM,
        );
        albums.add(Album(
            title: name,
            artistname: newAlbum.artist!,
            numOfSongs: newAlbum.numOfSongs,
            image: artWork!));
      }

      return albums;
    }
    return [];
  }
// Future<List> getSongDirectories () async{
//   List <FileSystemEntity> files=[];
//     await Permission.storage.request();

//   Config conf =await  Config.getInstance();
//   List? path = conf.storageDir?.listSync();
//   List<String> songPaths = await _audioQuery.queryAllPath();


// }

}



Future<List<FileSystemEntity>> getCacheFiles() async {
  List<FileSystemEntity> cacheFiles = [];
  // await handleDirectory();
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
