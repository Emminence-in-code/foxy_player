import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  const AudioSlider({super.key, required this.value});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      value: value == null?0.0:value!,
      activeColor: Colors.brown.shade400,
      inactiveColor: Colors.brown.shade100,
      onChanged: ((value) {}),
    );
  }
}
