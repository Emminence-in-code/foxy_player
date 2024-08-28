import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  Widget? child;
  NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.brown.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade300,
              blurRadius: 15,
              offset: const Offset(1, 1),
            ),
            BoxShadow(
              color: Colors.brown.shade300,
              blurRadius: 15,
              offset: const Offset(-1, -1),
            )
          ]),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
