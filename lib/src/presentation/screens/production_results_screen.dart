import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_pages.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/subtitle_widget.dart';
import '../widgets/titletext_widget.dart';

class ProductionResultsScreen extends StatelessWidget {
  final Map data;

  const ProductionResultsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colour.backGround,
        title: const Text('Calculation Results'),
        titleTextStyle: CustomTextStyle.titleStyle(Colour.orangeS400),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.productionScreen),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.dm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 10.0.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0.dm),
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
                              SubtitleWidget(
                                  text:
                                      ':  ${data['totalShots']} × ${data['cavity']}'),
                              SubtitleWidget(
                                  text: ':  ${data['totalBottle']} pcs'),
                              SubtitleWidget(
                                  text: ':  ${data['wastageBottle']} pcs'),
                              SubtitleWidget(
                                  text: ':  ${data['wastagePreform']} pcs'),
                              SubtitleWidget(
                                  text: ':  ${data['wellBottle']} pcs'),
                              SubtitleWidget(
                                  text: ':  ${data['usedRawMaterial']} kg'),
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
                              SubtitleWidget(
                                  text: ':  ${data['productionHours']}'),
                              SubtitleWidget(
                                  text: ':  ${data['downtimeHours']}'),
                              SubtitleWidget(
                                  text: ':  ${data['machineEfficiency']} %'),
                              SubtitleWidget(
                                  text: ':  ${data['expectedProduction']} pcs'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
