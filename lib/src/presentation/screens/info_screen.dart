import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../utils/constant/colour.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colour.backGround,
          centerTitle: true,
          title: Text(
            'Machines Constant Value',
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
              color: Colour.orangeS400,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Wise Hourly Max. Production Capacity:',
                style: TextStyle(fontSize: 14.0.sp),
              ),
              Gap(8.0.h),
              Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FractionColumnWidth(0.2),
                },
                children: [
                  buildRow([
                    'SN',
                    'Products',
                    'BPH',
                  ], isHeader: true),
                  buildRow([
                    '1.',
                    '500 ML',
                    '2400 pcs',
                  ]),
                  buildRow([
                    '2.',
                    '1000 ML',
                    '1920 pcs',
                  ]),
                  buildRow([
                    '3.',
                    '1500 ML',
                    '1200 pcs',
                  ]),
                  buildRow([
                    '4.',
                    '2000 ML',
                    '1200 pcs',
                  ])
                ],
              ),
            ],
          ),
        ));
  }
}

TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map((cell) {
      final TextStyle style = TextStyle(
        fontSize: 14.0.sp,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      );

      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Text(
          cell,
          style: style,
        )),
      );
    }).toList());
