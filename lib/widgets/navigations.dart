import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/nav_provider.dart';
import 'package:foxy_player/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class CustomNav extends StatelessWidget {
  const CustomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationProvider provider =
        Provider.of<NavigationProvider>(context);
    return BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.white54.withOpacity(0.5),
        currentIndex: provider.currentIndex,
        onTap: (value) {
          provider.updateCurrentIndex(newIndex: value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.video),
            label: "Videos",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.music),
            label: "Music",
          )
        ]);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 50;
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationProvider navProvider =
        Provider.of<NavigationProvider>(context);
    bool isOnVideoPage = navProvider.currentIndex == 0;

    return AppBar(
      title: Text(isOnVideoPage ? "V I D E O S" : "M U S I C"),
      centerTitle: true,
      backgroundColor: Colors.white.withOpacity(0.5),
      leading: IconButton(
        icon: const Icon(FontAwesomeIcons.bars),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: isOnVideoPage
                      ? VideoSearchDelegate()
                      : AudioSearchDelegate());
            },
            icon: const Icon(FontAwesomeIcons.magnifyingGlass))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
