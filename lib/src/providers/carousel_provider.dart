import 'package:flutter/material.dart';
import 'package:opticalc/src/data/image_data.dart';

class CarouselProvider with ChangeNotifier {
  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  final List<ImageData> imageData = [
    ImageData('assets/slider/slider_1.png'),
    ImageData('assets/slider/slider_2.png'),
    ImageData('assets/slider/slider_3.png'),
    ImageData('assets/slider/slider_4.png'),
    ImageData('assets/slider/slider_5.png'),
    ImageData('assets/slider/slider_6.png'),
    ImageData('assets/slider/slider_7.png'),
    ImageData('assets/slider/slider_8.png'),
  ];

  void updateActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
