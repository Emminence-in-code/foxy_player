import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  void updateCurrentIndex({required int newIndex}) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
