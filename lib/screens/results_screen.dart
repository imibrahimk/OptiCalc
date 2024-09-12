import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/subtitle_widget.dart';
import '../widgets/titletext_widget.dart';

class ResultsScreen extends StatelessWidget {
  final String totalShots;
  final String cavity;
  final String totalBottle;
  final String wastageBottle;
  final String wastagePreform;
  final String wellBottle;
  final String rawMaterialUsed;
  final String productionHours;
  final String machinesDowntime;
  final String machinesEfficiency;
  final String maxExpectedProduction;

  const ResultsScreen({
    super.key,
    required this.totalShots,
    required this.cavity,
    required this.totalBottle,
    required this.wastageBottle,
    required this.wastagePreform,
    required this.wellBottle,
    required this.rawMaterialUsed,
    required this.productionHours,
    required this.machinesDowntime,
    required this.machinesEfficiency,
    required this.maxExpectedProduction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        title: const Text('Calculation Results'),
        titleTextStyle: TextStyle(
            fontSize: 20.0.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14.0.r),
            bottomRight: Radius.circular(14.0.r),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.dm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8.0.dm),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0.w,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleTextWidget(text: "Total Prod. Shots"),
                            TitleTextWidget(text: "Total Prod. Bottle"),
                            TitleTextWidget(text: "Wastage Bottle"),
                            TitleTextWidget(text: "Wastage Preform"),
                            TitleTextWidget(text: "Good Prod. Bottle"),
                            TitleTextWidget(text: "Raw Material Used"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubtitleWidget(text: ':  $totalShots × $cavity'),
                            SubtitleWidget(text: ':  $totalBottle pcs'),
                            SubtitleWidget(text: ':  $wastageBottle pcs'),
                            SubtitleWidget(text: ':  $wastagePreform pcs'),
                            SubtitleWidget(text: ':  $wellBottle pcs'),
                            SubtitleWidget(text: ':  $rawMaterialUsed kg'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 16.0.h,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleTextWidget(text: "Production Hours"),
                            TitleTextWidget(text: "Machines Downtime"),
                            TitleTextWidget(text: "Machines Efficiency"),
                            TitleTextWidget(text: "Exp. Production"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubtitleWidget(text: ':  $productionHours'),
                            SubtitleWidget(text: ':  $machinesDowntime'),
                            SubtitleWidget(text: ':  $machinesEfficiency %'),
                            SubtitleWidget(
                                text: ':  $maxExpectedProduction pcs'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
