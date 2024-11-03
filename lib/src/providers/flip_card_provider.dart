import 'package:flutter/material.dart';
import '../services/card_printer.dart';

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

  Future<void> printCard(context, frontKey, backKey) async {
    final CardPrinter cardPrinter = CardPrinter();

    if (isFlipped) {
      toggleFlip();
      await Future.delayed(Duration(milliseconds: 1000));
      cardPrinter.generatePDF(context, frontKey, backKey);
    } else {
      cardPrinter.generatePDF(context, frontKey, backKey);
    }
  }
}
