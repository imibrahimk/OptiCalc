import 'package:flutter/material.dart';

// ChangeNotifier class to store the container dimensions

class FlipCardProvider with ChangeNotifier {
  bool _isFlipped = false;
  bool get isFlipped => _isFlipped;

  double? _width;
  double? _height;

  double? get width => _width;
  double? get height => _height;

  void toggleFlip() {
    _isFlipped = !_isFlipped;
    notifyListeners();
  }

  void setSize(double width, double height) {
    _width = width;
    _height = height;
    notifyListeners();
  }
}
