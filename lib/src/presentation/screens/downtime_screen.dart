import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/downtime_provider.dart';
import '../../routes/route_pages.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/titletext_widget.dart';

class DowntimeScreen extends StatelessWidget {
  const DowntimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Downtime'),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.homeScreen),
          icon: const Icon(Icons.arrow_back),
        ),
        titleTextStyle: CustomTextStyle.titleStyle(Colour.orangeS400),
        backgroundColor: Colour.backGround,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(17.0.dm),
        child: Consumer<DowntimeProvider>(
          builder: (context, provider, child) => Column(
            children: [
              CustomTextFormField(
                formKey: provider.planHoursFormKey,
                controller: provider.planHoursController,
                maxLength: 2,
                textInputType: TextInputType.number,
                labelText: 'Enter plan hours',
                onChanged: (value) => provider.validateInt(value),
              ),
              Gap(8.0.h),
              CustomTextFormField(
                formKey: provider.hourlyCapacityFormKey,
                controller: provider.hourlyCapacityController,
                maxLength: 5,
                textInputType: TextInputType.number,
                labelText: 'Enter hourly capacity',
                onChanged: (value) => provider.validateInt(value),
              ),
              Gap(8.0.h),
              CustomTextFormField(
                formKey: provider.producedQuantityFormKey,
                controller: provider.producedQuantityController,
                maxLength: 7,
                textInputType: TextInputType.number,
                labelText: 'Enter produced quantity',
                onChanged: (value) => provider.validateInt(value),
              ),
              Gap(8.0.h),
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
                      onTap: () => provider.resetFields(context),
                    ),
                  ),
                ],
              ),
              Gap(28.0.h),
              Card(
                color: Colour.backGround,
                elevation: 8.0.h,
                child: Container(
                  padding: EdgeInsets.all(12.0.dm),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(
                        text:
                            'Production Hours: ${provider.productionHours ?? ''}',
                      ),
                      TitleTextWidget(
                        text:
                            'Machine Downtime ${provider.machineDowntime ?? ''}',
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
