import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/developer_screen.dart';
import '../presentation/screens/downtime_screen.dart';
import '../presentation/screens/efficiency_screen.dart';
import '../presentation/screens/employees_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/info_screen.dart';
import '../presentation/screens/production_results_screen.dart';
import '../presentation/screens/production_screen.dart';
import '../presentation/screens/screen_holder.dart';
part 'routes.dart';

class RoutePages {
  static final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScreenHolder(child: child),
        routes: [
          GoRoute(
            path: Routes.homeScreen,
            name: Routes.homeScreen,
            pageBuilder: (context, state) => MaterialPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.productionScreen,
            name: Routes.productionScreen,
            pageBuilder: (context, state) => const MaterialPage(
              child: ProductionScreen(),
            ),
          ),
          GoRoute(
            path: Routes.productionResultsScreen,
            name: Routes.productionResultsScreen,
            pageBuilder: (context, state) => MaterialPage(
              child: ProductionResultsScreen(
                data: state.extra as Map,
              ),
            ),
          ),
          GoRoute(
            path: Routes.downtimeScreen,
            name: Routes.downtimeScreen,
            pageBuilder: (context, state) => const MaterialPage(
              child: DowntimeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.efficiencyScreen,
            name: Routes.efficiencyScreen,
            pageBuilder: (context, state) => const MaterialPage(
              child: EfficiencyScreen(),
            ),
          ),
          GoRoute(
            path: Routes.employeesScreen,
            name: Routes.employeesScreen,
            pageBuilder: (context, state) => MaterialPage(
              child: EmployeesScreen(),
            ),
          ),
          GoRoute(
            path: Routes.developerScreen,
            name: Routes.developerScreen,
            pageBuilder: (context, state) => const MaterialPage(
              child: DeveloperScreen(),
            ),
          ),
          GoRoute(
            path: Routes.infoScreen,
            name: Routes.infoScreen,
            pageBuilder: (context, state) => MaterialPage(
              child: InfoScreen(),
            ),
          )
        ],
      )
    ],
  );
}
