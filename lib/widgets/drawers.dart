import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxy_player/pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/new_art.png'))),
          ),
          const Divider(),
          const SizedBox(
            height: 25,
          ),
          DrawerItem(
            iconData: FontAwesomeIcons.gears,
            label: 'SETTINGS',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return const Scaffold();
                }),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(
            iconData: FontAwesomeIcons.shareNodes,
            label: 'SHARE',
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(
            iconData: FontAwesomeIcons.star,
            label: 'RATE US',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
  });
  final IconData iconData;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).closeDrawer();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(iconData),
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
