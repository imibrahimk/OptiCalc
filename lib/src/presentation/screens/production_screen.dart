import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/production_provider.dart';
import '../../routes/route_pages.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_text_form_field.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Production Calculation',
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
        padding: EdgeInsets.all(17.0.dm),
        child: Consumer<ProductionProvider>(
          builder: (context, provider, child) => Column(
            children: [
              CustomDropdown(
                items: provider.productionPlan,
                selectedValue: provider.selectedPlan,
                hintText: 'Select a plan',
                onChanged: provider.updateSelectedPlanValue,
              ),
              Gap(8.0.h),
              CustomDropdown(
                items: provider.productsName,
                selectedValue: provider.selectedProduct,
                hintText: 'Select a product',
                onChanged: provider.updateSelectedProductValue,
              ),
              Gap(8.0.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Present Counter:"),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        CustomTextFormField(
                          formKey: provider.presentShotFormKey,
                          controller: provider.presentShotTimesController,
                          validator: (value) =>
                              provider.inputValidation(value, context),
                          maxLength: 8,
                          textInputType: TextInputType.number,
                          labelText: 'Present shot',
                        ),
                        CustomTextFormField(
                          formKey: provider.presentBottleFormKey,
                          controller: provider.presentBottleQuantityController,
                          validator: (value) =>
                              provider.inputValidation(value, context),
                          maxLength: 8,
                          textInputType: TextInputType.number,
                          labelText: 'Present bottle',
                        ),
                      ],
                    ),
                  ),
                  Gap(8.0.w),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Previous Counter:"),
                        Gap(5.0.h),
                        CustomTextFormField(
                          formKey: provider.previousShotFormKey,
                          controller: provider.previousShotTimesController,
                          validator: (value) =>
                              provider.inputValidation(value, context),
                          maxLength: 8,
                          textInputType: TextInputType.number,
                          labelText: 'Previous shot',
                        ),
                        CustomTextFormField(
                          formKey: provider.previousBottleFormKey,
                          controller: provider.previousBottleQuantityController,
                          validator: (value) =>
                              provider.inputValidation(value, context),
                          maxLength: 8,
                          textInputType: TextInputType.number,
                          labelText: 'Previous bottle',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextFormField(
                      formKey: provider.hourlyCapacityFormKey,
                      controller: provider.presentHourlyCapacityController,
                      validator: (value) =>
                          provider.inputValidation(value, context),
                      maxLength: 4,
                      textInputType: TextInputType.number,
                      labelText: 'Hourly capacity',
                    ),
                  ),
                  Gap(8.0.w),
                  Expanded(
                    child: CustomTextFormField(
                      formKey: provider.wastageBottleFormKey,
                      controller: provider.wastageBottleController,
                      validator: (value) =>
                          provider.inputValidation(value, context),
                      maxLength: 4,
                      textInputType: TextInputType.number,
                      labelText: 'Wastage bottle',
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: 'Calculate',
                      icon: Icons.calculate_outlined,
                      onTap: () => provider.calculateProduction(context),
                    ),
                  ),
                  Gap(8.0.w),
                  Expanded(
                      flex: 1,
                      child: CustomButton(
                        title: 'Reset',
                        icon: Icons.restore_rounded,
                        onTap: () => provider.clearFields(context),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
