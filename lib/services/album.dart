import 'package:flutter/foundation.dart';

class Album{
  final String title;
  final String artistname;
  final int numOfSongs;
final Uint8List image;



  Album( {required this.image,  required this.title, required this.artistname, required this.numOfSongs}  );

}