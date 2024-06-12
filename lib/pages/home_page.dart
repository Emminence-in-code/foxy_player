import 'package:flutter/material.dart';
import 'package:foxy_player/models/models.dart';
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
    return ChangeNotifierProvider(
        create: (context) => AudioProvider(),
        builder: (context, audio) {
          return Scaffold(
            drawer: const CustomDrawer(),
            appBar: const CustomAppBar(),
            body: Consumer<NavigationProvider>(
              builder: (context, navProvider, _) {
                final index = navProvider.currentIndex;
                return screens[index];
              },
            ),
            bottomNavigationBar: const CustomNav(),
          );
        });
  }
}
