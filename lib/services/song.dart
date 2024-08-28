import 'package:flutter/foundation.dart';

class Song {
  final String title;
  final String artist;
  final String album;
final String filePath;
final Uint8List image;


  Song( {required this.image,required this.title, required this.artist,required this.album, required this.filePath});
}
