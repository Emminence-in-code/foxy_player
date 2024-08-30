import 'package:flutter/material.dart';
import 'package:foxy_player/pages/home_page.dart';

class FoxySplashScreen extends StatefulWidget {
  const FoxySplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoxySplashScreenState createState() => _FoxySplashScreenState();
}

class _FoxySplashScreenState extends State<FoxySplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      // duration of the splash screen
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/new_art.png'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Foxy Player',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.brown.shade300,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Icon(
                Icons.music_note_rounded,
                color: Colors.brown.shade300,
                size: 30,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
