import 'package:flutter/material.dart';
import 'package:foxy_player/models/models.dart';
import 'package:foxy_player/pages/audio_player_page.dart';
import 'package:foxy_player/screens/screens.dart';
import 'package:foxy_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final screens = [
    const VideoScreen(),
    const MusicScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final AudioProvider _audio = Provider.of<AudioProvider>(context);

    return ChangeNotifierProvider(
        create: (context) => AudioProvider(),
        builder: (context, audio) {

          return Scaffold(drawerEnableOpenDragGesture: true,
        
            drawer: const CustomDrawer(),
            appBar: const CustomAppBar(),
            bottomNavigationBar: const CustomNav(),
            body: Consumer<NavigationProvider>(
              builder: (context, navProvider, _) {
                
                final index = navProvider.currentIndex;
                return Stack(
                  children: [
                    screens[index],
                         Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Consumer<AudioProvider>(builder: (context, aud, _) {
            if (aud.audioPlayer.playing) {
              aud.visible = true;
            }
            if (!aud.visible) return Container();
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return AudioPlayerPage(
                    song: _audio.currentTrack,
                    audioProvider: _audio,
                  );
                }));
              },
              onHorizontalDragEnd: (details) async {
                if (details.primaryVelocity! < 0.0) {
                  await _audio.playPrev();

                  // prev
                } else if (details.primaryVelocity! > 0.0) {
                  // next
                  await _audio.playNext();
                }
              },
              child: BottomAudioPlayer(
                title: _audio.currentTrack.title,
                onNext: () async {
                  await _audio.playNext();
                },
                onPlay: () async {
                  await _audio.togglePlay();
                },
                onPrev: () async {
                  await _audio.playPrev();
                },
                isPlaying: _audio.audioPlayer.playing,
                image: _audio.currentTrack.image,
              ),
            );
          }),
        )
                  ],
                );
              },
            ),
          );
        });
  }
}
