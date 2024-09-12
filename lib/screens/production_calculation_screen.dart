import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../calculator/calculations.dart';
import '../widgets/my_dropdown.dart';

import 'results_screen.dart';

// ignore: must_be_immutable
class ProductionCalculationScreen extends StatelessWidget {
  ProductionCalculationScreen({super.key});

  final List<String> productionPlanHours = [
    "08 Hours",
    "12 Hours",
    "16 Hours",
    "24 Hours",
  ];

  final List<String> productsName = [
    "500 ML",
    "1000 ML",
    "1500 ML",
    "2000 ML",
  ];

  String? selectedPlanHour;
  String? selectedProductName;

  final TextEditingController _prevShotTimesController =
      TextEditingController();
  final TextEditingController _prevBottleQuantityController =
      TextEditingController();

  final TextEditingController _presentShotTimesController =
      TextEditingController();
  final TextEditingController _presentBottleQuantityController =
      TextEditingController();

  final TextEditingController _hourlyCapacityController =
      TextEditingController();
  final TextEditingController _wastageBottleController =
      TextEditingController();

  // Reference to DropdownMenuListState to access its methods
  final GlobalKey<MyDropdownState> _selectPlanKey = GlobalKey();
  final GlobalKey<MyDropdownState> _selectProductKey = GlobalKey();

  // GlobalKey for use TextFormField Validation
  final GlobalKey<FormState> _previousShotKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _previousBottleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _presentShotKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _presentBottleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hourlyCapacityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _wastageBottleKey = GlobalKey<FormState>();

// veriable for show results on textview
  int? totalShots;
  int? cavity;
  int? totalBottle;
  String? wastageBottle;
  int? wastagePreform;
  int? wellProducedBottle;
  double? usedRawMaterial;

  String? productionHours;
  String? downtimeHours;
  int? machineEfficiency;
  int? maxExpectedProduction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(17.0.dm),
        child: Column(
          children: [
            MyDropdown(
                key: _selectPlanKey,
                hintText: "Select a plan hours",
                listItem: productionPlanHours,
                selectedData: (value) {
                  selectedPlanHour = value;
                }),
            SizedBox(
              height: 8.0.h,
            ),
            MyDropdown(
                key: _selectProductKey,
                hintText: "Select a product size",
                listItem: productsName,
                selectedData: (value) {
                  selectedProductName = value;
                }),
            SizedBox(
              height: 8.0.h,
            ),
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
                      Form(
                        key: _presentShotKey,
                        child: TextFormField(
                          controller: _presentShotTimesController,
                          validator: (value) => inputValidation(value),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Prs. shot times',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: _presentBottleKey,
                        child: TextFormField(
                          controller: _presentBottleQuantityController,
                          validator: (value) => inputValidation(value),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Prs. bottle quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Previous Counter:"),
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Form(
                        key: _previousShotKey,
                        child: TextFormField(
                          controller: _prevShotTimesController,
                          validator: (value) => inputValidation(value),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Prev. shot times',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: _previousBottleKey,
                        child: TextFormField(
                          controller: _prevBottleQuantityController,
                          validator: (value) => inputValidation(value),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Prev. bottle quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          ),
                        ),
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
                  child: Form(
                    key: _hourlyCapacityKey,
                    child: TextFormField(
                      controller: _hourlyCapacityController,
                      validator: (value) => inputValidation(value),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Hourly capacity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                Expanded(
                  child: Form(
                    key: _wastageBottleKey,
                    child: TextFormField(
                      controller: _wastageBottleController,
                      validator: (value) => inputValidation(value),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Wastage bottle',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () => handleCalculateButtonClick(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calculate_outlined),
                        SizedBox(width: 8.0.w),
                        const Text("Calculate"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () => handleClearButtonClick(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.clear_all_outlined),
                        SizedBox(width: 8.0.w),
                        const Text("Clear"),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //========================Function For This Classes====================================

  void handleCalculateButtonClick(context) {
    if (selectedPlanHour == null) {
      showToast("Please select a plan hours");
      return;
    }

    if (selectedProductName == null) {
      showToast("Please select a product size");
      return;
    }

    if (_previousShotKey.currentState!.validate() == false) {
      return;
    }
    if (_previousBottleKey.currentState!.validate() == false) {
      return;
    }

    if (_presentShotKey.currentState!.validate() == false) {
      return;
    }
    if (_presentBottleKey.currentState!.validate() == false) {
      return;
    }

    if (_hourlyCapacityKey.currentState!.validate() == false) {
      return;
    }

    if (_wastageBottleKey.currentState!.validate() == false) {
      return;
    }

    FocusScope.of(context).unfocus(); // clear focus and close keyboard

    Calculations calculator = Calculations(
      selectedPlanHour!,
      selectedProductName!,
      int.parse(_prevShotTimesController.text),
      int.parse(_prevBottleQuantityController.text),
      int.parse(_presentShotTimesController.text),
      int.parse(_presentBottleQuantityController.text),
      int.parse(_hourlyCapacityController.text),
      int.parse(_wastageBottleController.text),
    );

    totalShots = calculator.calculateTotalShot();
    cavity = calculator.calculateCavity();
    totalBottle = calculator.calculateTotalBottle();
    wastageBottle = _wastageBottleController.text;
    wastagePreform = calculator.calculateWastagePreform();
    wellProducedBottle = calculator.calculateWellBottle();
    usedRawMaterial = calculator.calculateUsedRawMaterial();
    productionHours = calculator.calculateProductionHours();
    downtimeHours = calculator.calculateMachineDowntime();
    machineEfficiency = calculator.calculateMachineEfficiency().toInt();
    maxExpectedProduction = calculator.calculateExpectedProduction();

// navigate

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          totalShots: totalShots.toString(),
          cavity: cavity.toString(),
          totalBottle: totalBottle.toString(),
          wastageBottle: wastageBottle!,
          wastagePreform: wastagePreform.toString(),
          wellBottle: wellProducedBottle.toString(),
          rawMaterialUsed: usedRawMaterial!.toStringAsFixed(3),
          productionHours: productionHours!,
          machinesDowntime: downtimeHours!,
          machinesEfficiency: machineEfficiency.toString(),
          maxExpectedProduction: maxExpectedProduction.toString(),
        ),
      ),
    );
  }

  void handleClearButtonClick(context) {
    // Update MyDropdownMenu using the GlobalKey
    _selectProductKey.currentState?.resetDropdownSelection();
    _selectPlanKey.currentState?.resetDropdownSelection();

    selectedPlanHour = null;
    selectedProductName = null;

    _prevShotTimesController.clear();
    _prevBottleQuantityController.clear();

    _presentShotTimesController.clear();
    _presentBottleQuantityController.clear();

    _hourlyCapacityController.clear();
    _wastageBottleController.clear();

    _previousShotKey.currentState!.reset();
    _previousBottleKey.currentState!.reset();
    _presentShotKey.currentState!.reset();
    _presentBottleKey.currentState!.reset();
    _hourlyCapacityKey.currentState!.reset();
    _wastageBottleKey.currentState!.reset();

    FocusScope.of(context).unfocus(); // clear focus and close keyboard

    showToast("All fields data cleared!");
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String? inputValidation(value) {
    if (value == null || value.isEmpty) {
      showToast("এটা খালি রাখা যাবে না");
      return '* required';
    }

    final isInteger = RegExp(r'^[0-9]+$').hasMatch(value);
    if (!isInteger) {
      return 'Enter numeric data';
    }

    return null;
  }
}
