import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'src/providers/bottom_nav_provider.dart';
import 'src/providers/carousel_provider.dart';
import 'src/providers/downtime_provider.dart';
import 'src/providers/efficiency_provider.dart';
import 'src/providers/flip_card_provider.dart';
import 'src/providers/production_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarouselProvider()),
        ChangeNotifierProvider(create: (_) => ProductionProvider()),
        ChangeNotifierProvider(create: (_) => EfficiencyProvider()),
        ChangeNotifierProvider(create: (_) => FlipCardProvider()),
        ChangeNotifierProvider(create: (_) => DowntimeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const App(),
    ),
  );
}
