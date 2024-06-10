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
              color: Colors.brown.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.brown.shade500,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            )
          ]),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
