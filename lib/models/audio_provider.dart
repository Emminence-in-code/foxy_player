import 'package:flutter/material.dart';
import 'package:foxy_player/services/services.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer;
  String? uri;
  List<Song> playList = [];
  Song? currentTrack;
  bool visible = false;
  AudioProvider() : audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose().then((value) => super.dispose());
  }

  Future<Duration?> playAudio(String uri, {Song? song}) async {
    /// perform error handling from where function is being called

    final Duration? duration =
        await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));

    await audioPlayer.play();
    notifyListeners();

    return duration;
  }

  bool hasAudioSource() {
    return audioPlayer.audioSource != null;
  }

  void setVisible() {
    visible = true;
    notifyListeners();
  }

  Future<void> togglePlay() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }

    notifyListeners();
  }

  Future<void> playNext() async {
    await audioPlayer.pause();
    Song nextSong;
    if (playList.isEmpty) {
      return;
    }
    int currentIndex = playList.indexOf(currentTrack!);
    if (currentIndex == playList.length - 1) {
      nextSong = playList[0];
      currentTrack = nextSong;

      notifyListeners();
    } else {
      nextSong = playList[currentIndex + 1];
      currentTrack = nextSong;

      notifyListeners();
    }
    await playAudio(nextSong.filePath, song: nextSong);

    notifyListeners();
  }

  Future<void> playPrev() async {
    await audioPlayer.pause();
    Song nextSong;
    if (playList.isEmpty) {
      return;
    }
    int currentIndex = playList.indexOf(currentTrack!);
    if (currentIndex == 0) {
      nextSong = playList.last;
      currentTrack = nextSong;
      notifyListeners();
    } else {
      nextSong = playList[currentIndex - 1];
      currentTrack = nextSong;
      notifyListeners();
    }
    await playAudio(nextSong.filePath, song: nextSong);
    notifyListeners();
  }

  void setPlaylist(List<Song> songs) {
    playList = songs;
  }
}
