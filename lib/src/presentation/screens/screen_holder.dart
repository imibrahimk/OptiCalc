import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bottom_nav_provider.dart';

class ScreenHolder extends StatelessWidget {
  final Widget child;
  const ScreenHolder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, provider, child) => NavigationBar(
          selectedIndex: provider.activeIndex, // Use provider's activeIndex
          onDestinationSelected: (index) => provider.onDestinationSelected(
              context, index), // Update index through provider
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Developer'),
          ],
        ),
      ),
    );
  }
}
