import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/file_provider.dart';
import 'package:foxy_player/services/song.dart';
import 'package:foxy_player/widgets/media_items.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:provider/provider.dart';

class VideoSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == '') {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.cancel))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null); //for closing search bar
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // get list of videos from provider
    final List<VideoDetails> searchItems =
        Provider.of<FileProvider>(context).videoFiles;
    List<VideoDetails> matchingQuery = [];
    for (var item in searchItems) {
      if (item.videoName.toLowerCase().contains(query.toLowerCase())) {
        matchingQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchingQuery.length,
        itemBuilder: (context, index) {
          return VideoItem(videoItem: matchingQuery[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // get list of videos from provider
    final List<VideoDetails> searchItems =
        Provider.of<FileProvider>(context).videoFiles;
    List<VideoDetails> matchingQuery = [];
    for (var item in searchItems) {
      if (matchingQuery.length >= 4) {
        break;
      }
      if (item.videoName.toLowerCase().contains(query.toLowerCase())) {
        matchingQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchingQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRotateLeft),
            title: Text(matchingQuery[index].videoName),
            onTap: () {
              query = matchingQuery[index].videoName;
              showResults(context);
            },
          );
        });
  }
}

class AudioSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == '') {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.cancel))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null); //for closing search bar
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // get list of videos from provider
    final List<Song> searchItems =
        Provider.of<FileProvider>(context).audioFiles;
    List<Song> matchingQuery = [];
    for (var item in searchItems) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchingQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchingQuery.length,
        itemBuilder: (context, index) {
          return AudioItem(
            song: matchingQuery[index],
            onTap: () {},
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // get list of videos from provider
    final List<Song> searchItems =
        Provider.of<FileProvider>(context).audioFiles;
    List<Song> matchingQuery = [];
    for (var item in searchItems) {
      if (matchingQuery.length >= 4) {
        break;
      }
      if (item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.album.toLowerCase().contains(query.toLowerCase()) ||
          item.artist.toLowerCase().contains(query.toLowerCase())) {
        matchingQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchingQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRotateLeft),
            title: Text(matchingQuery[index].title),
            onTap: () {
              query = matchingQuery[index].title;
              showResults(context);
            },
          );
        });
  }
}
