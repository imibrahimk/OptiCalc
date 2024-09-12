import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticalc/screens/downtime_screen.dart';
import '../widgets/category_item.dart';
import 'production_calculation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // navigator fun
    void navigateScreen({required Widget screen}) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => screen));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OptiCalc: S. A. Beverage Limited',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: GridView(
          padding: EdgeInsets.all(12.0.dm),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0.dm,
            crossAxisSpacing: 8.0.dm,
            childAspectRatio: 4 / 3,
          ),
          children: [
            CategoryItem(
              title: 'Production\nCalculate',
              onTap: () =>
                  navigateScreen(screen: ProductionCalculationScreen()),
            ),
            CategoryItem(
              title: 'Downtime\nCalculate',
              onTap: () => navigateScreen(screen: DowntimeScreen()),
            )
          ],
        ),
      ),
    );
  }
}
