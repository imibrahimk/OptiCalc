import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/efficiency_provider.dart';
import '../../routes/route_pages.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/titletext_widget.dart';

class EfficiencyScreen extends StatelessWidget {
  const EfficiencyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Efficiency Calculation',
          style: CustomTextStyle.subTitleStyle(Colour.orangeS400),
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.homeScreen),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colour.backGround,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.dm),
        child: Consumer<EfficiencyProvider>(
          builder: (context, provider, child) => Column(
            children: [
              CustomDropdown(
                  items: provider.productionPlan,
                  selectedValue: provider.selectedPlan,
                  hintText: 'Select a plan',
                  onChanged: provider.updateSelectedPlanValue),
              Gap(16.0.h),
              CustomDropdown(
                  items: provider.productsName,
                  selectedValue: provider.selectedProduct,
                  hintText: 'Select a product',
                  onChanged: provider.updateSelectedProductValue),
              Gap(16.0.h),
              Column(
                children: [
                  TextFormField(
                    controller: provider.machineDowntimeController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: 'Enter the downtime',
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      controller: provider.producedBottleQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter produced bottle',
                        filled: true,
                        fillColor: Colors.blue.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: 'Calculate',
                      icon: Icons.calculate_outlined,
                      onTap: () => provider.calculate(context),
                    ),
                  ),
                  Gap(12.0.w),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: 'Reset',
                      icon: Icons.restore_rounded,
                      onTap: () => provider.resetFields(),
                    ),
                  ),
                ],
              ),
              Gap(16.0.h),
              Card(
                elevation: 8.0.h,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0.dm),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12.0.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(
                        text:
                            'Machine Efficiency:   ${provider.machineEfficiency ?? ''} %',
                      ),
                      Gap(12.0.h),
                      TitleTextWidget(
                        text:
                            'Expected Production:   ${provider.maxExpectedProduction ?? ''} pcs',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
