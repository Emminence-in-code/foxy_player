import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy_player/config/config.dart';
import 'package:foxy_player/services/file_services.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/services/utils.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:permission_handler/permission_handler.dart';

class FileProvider extends ChangeNotifier {
  List<VideoDetails> videoFiles = [];
  List<Song> audioFiles = [];
  List<FileSystemEntity> cacheFiles = [];
  final Audio _audio = Audio();

  Future<void> findFiles({bool rebuild = false}) async {
    // write a code
    // check if audiofiles and videofile #LISTS are empty
    //  if empty find files and display loading
    // if not empty findfiles without disturbing ui

    final Config appConfig = await Config.getInstance();
    bool hasPerm = await Permission.storage.isGranted;

    if (hasPerm) {
      await _getVideoFiles();
      await _getAudioFiles();
      notifyListeners();
      final videos = getVideoFileList(videoFiles);
      final audios = getAudiofileList(audioFiles);

      final Map<String, List<Map>> saveData = {
        'videos': videos,
        'audios': audios,
      };
      final savePath =
          '${(await Config.getInstance()).cacheDir!.path}/${Config.saveDataFileName}${Config.saveDataExtension}';

      writeJsonToFile(path: savePath, data: saveData);
    } else {
      await Permission.storage.request();
    }
    if (rebuild) {
      notifyListeners();
    }
  }

  Future<void> _getVideoFiles() async {
    final tempVideo = await getVideoFiles();

    // todo check if videoFiles matches the caches list of video file before updating the ui
    if (videoFiles != tempVideo) {
      videoFiles = tempVideo;
      notifyListeners();
    }
  }

  Future<void> _getAudioFiles() async {
    final tempAudio = await _audio.getAudios();
    // todo check if audioFiles matches the caches list of audio file before updating the ui
    if (tempAudio != audioFiles) {
      audioFiles = tempAudio;
      notifyListeners();
    }
  }

  Future<void> readFiles() async {
    final savePath =
        '${(await Config.getInstance()).cacheDir!.path}/${Config.saveDataFileName}${Config.saveDataExtension}';
    final filesAsJson = readFileAsJson(path: savePath);

    // get videos
    List<VideoDetails> videos = [];
    final List videoPaths =
        filesAsJson.containsKey('videos') ? filesAsJson['videos'] : [];
    if (videoPaths.isEmpty) return;
    for (var videoItem in videoPaths) {
      VideoDetails video = VideoDetails(videoItem['video']);
      videos.add(video);
    }
    if (videos.isNotEmpty) {
      videoFiles = [...videos];
      notifyListeners();
    }

// get audios
    List<Song> songs = [];
    final List audios = filesAsJson['audios'];
    for (var audioItem in audios) {
      Song newSong = Song(image: audioItem['image'],
          album: audioItem['album'],
          title: audioItem['title'],
          artist: audioItem['artist'],
          filePath: audioItem['filePath']);

      songs.add(newSong);
    }
    if (songs.isNotEmpty) {
      audioFiles = [...songs];
      notifyListeners();
    }
  }

  List<Map> getAudiofileList(List<Song> audioFiles) {
    ///for serializing audio files
    final List<Map> mapAudioData = [];
    for (var audiofile in audioFiles) {
      mapAudioData.add({
        'image':audiofile.image,
        'title': audiofile.title,
        'album': audiofile.album,
        'artist': audiofile.artist,
        'filePath': audiofile.filePath
      });
    }
    return mapAudioData;
  }

  List<Map> getVideoFileList(List<VideoDetails> videoFiles) {
    /// for serializing video files
    final List<Map> mapVideoData = [];
    for (var videoFile in videoFiles) {
      mapVideoData.add({'video': videoFile.videoPath});
    }
    return mapVideoData;
  }
}
