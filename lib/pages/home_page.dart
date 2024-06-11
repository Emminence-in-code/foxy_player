import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/nav_provider.dart';
import 'package:foxy_player/widgets/widgets.dart';
import 'package:foxy_player/screens/screens.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final screens = [
    const VideoScreen(),
    MusicScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
  }
}
