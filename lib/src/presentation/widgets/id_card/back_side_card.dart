import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../providers/flip_card_provider.dart';
import '../../../utils/constant/colour.dart';
import '../../../utils/constant/custom_text_style.dart';

class BackSideCard extends StatelessWidget {
  final GlobalKey? repaintBoundaryKey; // Accept the key

  const BackSideCard({
    super.key,
    this.repaintBoundaryKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FlipCardProvider>(
      builder: (context, sizeProvider, child) {
        return RepaintBoundary(
          key: repaintBoundaryKey,
          child: Card(
            color: Colors.white,
            // elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0.r),
            ),
            child: Container(
              width: sizeProvider.width,
              height: sizeProvider.height,
              padding: EdgeInsets.only(top: 12.0.dm),
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
                  Image.asset(
                    'assets/logo/sa_logo.png',
                    scale: 1.8,
                  ),
                  Text(
                    'S. A GROUP OF INDUSTRIES',
                    style: TextStyle(
                      fontFamily: 'TavernS',
                      color: Colour.orangeS400,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'W O R K  H A R D, M A K E  H I S T O R Y',
                    style: TextStyle(
                      color: const Color(0xffA52A2A),
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.0.h),
                  Text(
                    'HEAD OFFICE',
                    style: CustomTextStyle.subTitleStyle(Colour.darkBlue),
                  ),
                  Text(
                    '5th Floor, The Traingle Tower 168/A/429\n10Zakir Hossain Road, South Khulshi\nChattogram, Bangladesh',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.normalBoldStyle(Colour.darkBlue),
                  ),
                  Gap(12.0.h),
                  Text(
                    'Phone : 88-02333365493 or\n88-02333368895\nE-mail : muskanad96@gmail.com',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.normalBoldStyle(Colour.darkBlue),
                  ),
                  Gap(8.0.h),
                  Text(
                    'FACTORY',
                    style: CustomTextStyle.subTitleStyle(Colour.darkBlue),
                  ),
                  Text(
                    'Bhatiari Industrial Park, Sitakunda\nChattogram',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.normalBoldStyle(Colour.darkBlue),
                  ),
                  Gap(8.0.h),
                  Text(
                    textAlign: TextAlign.center,
                    'This id card is the property of the company\nand it must be returned to the above\naddress if found.',
                    style: CustomTextStyle.normalBoldStyle(Colour.darkBlue),
                  ),
                  Gap(12.0.h),
                  Container(
                    width: double.infinity,
                    color: Colour.darkBlue,
                    padding: EdgeInsets.symmetric(vertical: 2.0.h),
                    child: Center(
                      child: Text(
                        'www.sagroupbd.com',
                        style: CustomTextStyle.normalTextStyle(Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
