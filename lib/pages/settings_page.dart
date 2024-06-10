import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            style: TextStyle(
              letterSpacing: 4,
            ),
            'Settings'),
        toolbarHeight: 120,
        centerTitle: true,
      ),
      body: const Column(
        children: [ThemeSwitch(),
        
        ],
      ),
    );
  }
}
