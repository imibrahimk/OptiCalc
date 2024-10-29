import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:opticalc/src/providers/card_printer_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/constant/colour.dart';
import '../../../utils/constant/custom_text_style.dart';
import '../circular_image.dart';

class FrontSideCard extends StatelessWidget {
  final GlobalKey? repaintBoundaryKey; // Accept the key
  final Map<String, String> data;

  FrontSideCard({
    super.key,
    this.repaintBoundaryKey,
    required this.data,
  });

  final GlobalKey _frontContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to get size after rendering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _frontContainerKey.currentContext?.findRenderObject() as RenderBox;
      final width = renderBox.size.width;
      final height = renderBox.size.height;
      Provider.of<CardPrinterProvider>(context, listen: false)
          .setSize(width, height);
    });

    return RepaintBoundary(
      key: repaintBoundaryKey,
      child: Container(
        key: _frontContainerKey,
        padding: EdgeInsets.only(top: 16.0.dm, bottom: 8.0.dm),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5.w,
            color: Colour.darkBlue,
          ),
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/sa_logo.png',
                  ),
                  Text(
                    'W O R K  H A R D, M A K E  H I S T O R Y',
                    style: TextStyle(
                      color: const Color(0xffA52A2A),
                      fontSize: 10.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gap(12.0.h),
            CircularImage(
              image: data['photo']!,
            ),
            Gap(5.0.h),
            Text(
              '${data['name']}',
              style: CustomTextStyle.titleStyle(Colour.darkBlue),
            ),
            Text(
              '${data['designation']}',
              style: CustomTextStyle.subTitleStyle(Colour.darkBlue),
            ),
            Gap(14.0.h),
            Container(
              padding: EdgeInsets.only(
                top: 5.0.dm,
                bottom: 12.0.r,
                left: 12.0.dm,
                right: 12.0.dm,
              ),
              width: double.infinity,
              color: Colour.darkBlue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'S. A. Beverage Limited',
                    style: CustomTextStyle.titleStyle(Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.0.w),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 28.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Department',
                                      style: CustomTextStyle.normalTextStyle(
                                          Colors.white)),
                                  Text('Joining Date',
                                      style: CustomTextStyle.normalTextStyle(
                                          Colors.white)),
                                  Text('Employee ID',
                                      style: CustomTextStyle.normalTextStyle(
                                          Colors.white)),
                                  Text('Blood Group',
                                      style: CustomTextStyle.normalTextStyle(
                                          Colors.white)),
                                  Text('Mobile No',
                                      style: CustomTextStyle.normalTextStyle(
                                          Colors.white)),
                                ],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(':   PET Bottle',
                                  style: CustomTextStyle.normalTextStyle(
                                      Colors.white)),
                              Text(':   ${data['joiningDate']}',
                                  style: CustomTextStyle.normalTextStyle(
                                      Colors.white)),
                              Text(':   ${data['id']}',
                                  style: CustomTextStyle.normalTextStyle(
                                      Colors.white)),
                              Text(':   ${data['bloodGroup'] ?? ''}',
                                  style: CustomTextStyle.normalTextStyle(
                                      Colors.white)),
                              Text(':   ${data['mobileNo']}',
                                  style: CustomTextStyle.normalTextStyle(
                                      Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(8.0.dm),
            Image.asset(
              'assets/logo/auth_sing.png',
              width: 100.0.w,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.5.w, color: Colour.darkBlue),
                ),
              ),
              child: Text(
                'AUTHORIZED SIGNATURE',
                style: TextStyle(
                    color: Colour.darkBlue,
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
