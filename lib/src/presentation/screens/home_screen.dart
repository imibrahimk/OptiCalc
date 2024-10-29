import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_pages.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Image> imageList = [
    Image.asset('assets/staff/khalil.png'),
    Image.asset('assets/staff/raihan.png'),
    Image.asset('assets/staff/jabed.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OptiCalc: PET Bottle(ASB), SABL',
          style: CustomTextStyle.subTitleStyle(Colour.orangeS400),
        ),
        centerTitle: true,
        backgroundColor: Colour.backGround,
      ),
      body: CustomScrollView(
        slivers: [
          // SliverList for the horizontal CarouselView
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                ),
                items: imageList,
              ),
            ),
          ),

          // SliverGrid.count for the GridView below the CarouselView
          SliverPadding(
            padding: EdgeInsets.all(8.0.dm),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0.dm,
              crossAxisSpacing: 8.0.dm,
              childAspectRatio: 4 / 3,
              children: [
                CategoryCard(
                  icon: 'assets/icon/prod_icon.png',
                  title: 'Production',
                  onTap: () => context.goNamed(Routes.productionScreen),
                ),
                CategoryCard(
                  icon: 'assets/icon/downtime_icon.png',
                  title: 'Downtime',
                  onTap: () => context.goNamed(Routes.downtimeScreen),
                ),
                CategoryCard(
                  icon: 'assets/icon/efficiency_icon.png',
                  title: 'Efficiency',
                  onTap: () => context.goNamed(Routes.efficiencyScreen),
                ),
                CategoryCard(
                  icon: 'assets/icon/team_icon.png',
                  title: 'Employees',
                  onTap: () => context.goNamed(Routes.employeesScreen),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// GridView(
//         padding: EdgeInsets.all(12.0.dm),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 8.0.dm,
//           crossAxisSpacing: 8.0.dm,
//           childAspectRatio: 4 / 3,
//         ),
//         children: [
//           CategoryCard(
//             icon: 'assets/icon/prod_icon.png',
//             title: 'Production',
//             onTap: () => context.goNamed(Routes.productionScreen),
//           ),
//           CategoryCard(
//             icon: 'assets/icon/downtime_icon.png',
//             title: 'Downtime',
//             onTap: () => context.goNamed(Routes.downtimeScreen),
//           ),
//           CategoryCard(
//             icon: 'assets/icon/efficiency_icon.png',
//             title: 'Efficiency',
//             onTap: () => context.goNamed(Routes.efficiencyScreen),
//           ),
//           CategoryCard(
//             icon: 'assets/icon/team_icon.png',
//             title: 'Employees',
//             onTap: () => context.goNamed(Routes.employeesScreen),
//           )
//         ],
//       )
