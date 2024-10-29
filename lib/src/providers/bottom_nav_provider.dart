import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/route_pages.dart';

class BottomNavProvider with ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void onDestinationSelected(BuildContext context, int newIndex) {
    _activeIndex = newIndex;
    notifyListeners();

    // Navigate to the respective route based on the index
    switch (newIndex) {
      case 0:
        context.goNamed(Routes.homeScreen);
        break;
      case 1:
        context.goNamed(Routes.infoScreen);
        break;
      case 2:
        context.goNamed(Routes.developerScreen);
        break;
      default:
        context.goNamed(Routes.homeScreen);
    }
  }
}
