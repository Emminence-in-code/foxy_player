import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.angleLeft),
            onPressed: () {},
          ),
          const TextField(),
          // ignore: deprecated_member_use
          IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.close))
        ],
      ),
    );
  }
}
