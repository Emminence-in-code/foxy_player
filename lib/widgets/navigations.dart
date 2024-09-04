import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/models/nav_provider.dart';
import 'package:foxy_player/widgets/drawers.dart';
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
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 20,
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

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });
  final double height = 50;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    bool isOpen = !Scaffold.of(context).isDrawerOpen;

    final NavigationProvider navProvider =
        Provider.of<NavigationProvider>(context);
    bool isOnVideoPage = navProvider.currentIndex == 0;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        isOnVideoPage ? "V I D E O S" : "M U S I C",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(0.5),
      actions: [
        IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu))
      ],
    );
  }
}
