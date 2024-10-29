import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../calculation/production_calc.dart';
import '../routes/route_pages.dart';

class ProductionProvider with ChangeNotifier {
  final List<String> productionPlan = [
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

  String? _selectedPlan;
  String? _selectedProduct;

  String? get selectedPlan => _selectedPlan;
  String? get selectedProduct => _selectedProduct;

  // Update selected value from dropdown
  void updateSelectedPlanValue(String? newValue) {
    _selectedPlan = newValue;
    notifyListeners();
  }

  void updateSelectedProductValue(String? newValue) {
    _selectedProduct = newValue;
    notifyListeners();
  }

  final GlobalKey<FormState> presentShotFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> presentBottleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> previousShotFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> previousBottleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> hourlyCapacityFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> wastageBottleFormKey = GlobalKey<FormState>();

  final TextEditingController presentShotTimesController =
      TextEditingController();
  final TextEditingController presentBottleQuantityController =
      TextEditingController();
  final TextEditingController previousShotTimesController =
      TextEditingController();
  final TextEditingController previousBottleQuantityController =
      TextEditingController();
  final TextEditingController presentHourlyCapacityController =
      TextEditingController();
  final TextEditingController wastageBottleController = TextEditingController();

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

  // Calculate production and navigate screen
  void calculateProduction(BuildContext context) {
    if (_selectedPlan == null) {
      showSnackbar(context, "Please select a plan");
      return;
    }

    if (_selectedProduct == null) {
      showSnackbar(context, "Please select a product");
      return;
    }

    if (presentShotTimesController.text.isEmpty) {
      showSnackbar(context, "Please enter present shots");
      return;
    }

    if (presentBottleQuantityController.text.isEmpty) {
      showSnackbar(context, "Please enter present bottle");
      return;
    }

    if (previousShotTimesController.text.isEmpty) {
      showSnackbar(context, "Please enter previous shots");
      return;
    }

    if (previousBottleQuantityController.text.isEmpty) {
      showSnackbar(context, "Please enter previous bottle");
      return;
    }

    if (presentHourlyCapacityController.text.isEmpty) {
      showSnackbar(context, "Please enter hourly capacity");
      return;
    }

    if (wastageBottleController.text.isEmpty) {
      showSnackbar(context, "Please enter wastage bottle");
      return;
    }

    final ProductionCalc prodCalc = ProductionCalc(
        selectedPlan: _selectedPlan!,
        selectedProduct: _selectedProduct!,
        presentShotCounter: int.parse(presentShotTimesController.text),
        presentBottleCounter: int.parse(presentBottleQuantityController.text),
        previousShotCounter: int.parse(previousShotTimesController.text),
        previousBottleCounter: int.parse(previousBottleQuantityController.text),
        presentHourlyBottleProduction:
            int.parse(presentHourlyCapacityController.text),
        wastageBottleQuantity: int.parse(wastageBottleController.text));

    // Calculate production data
    totalShots = prodCalc.calculateTotalShotTimes();
    cavity = prodCalc.calculateNumOfCavity();
    totalBottle = prodCalc.calculateTotalBottleQuantity();
    wastageBottle = wastageBottleController.text;
    wastagePreform = prodCalc.calculateWastagePreform();
    wellProducedBottle = prodCalc.calculateWellBottleQuantity();
    usedRawMaterial = prodCalc.calculateUsedRawMaterial();
    productionHours = prodCalc.calculateProductionHours();
    downtimeHours = prodCalc.calculateMachineDowntime();
    machineEfficiency = prodCalc.calculateMachineEfficiency().toInt();
    maxExpectedProduction = prodCalc.calculateExpectedProduction();

    // Navigate to results screen
    context.goNamed(
      Routes.productionResultsScreen,
      extra: {
        'totalShots': '$totalShots',
        'cavity': '$cavity',
        'totalBottle': '$totalBottle',
        'wastageBottle': '$wastageBottle',
        'wastagePreform': '$wastagePreform',
        'wellBottle': '$wellProducedBottle',
        'usedRawMaterial': '$usedRawMaterial',
        'productionHours': '$productionHours',
        'downtimeHours': '$downtimeHours',
        'machineEfficiency': '$machineEfficiency',
        'expectedProduction': '$maxExpectedProduction',
      },
    );
  }

  void clearFields(context) {
    _selectedPlan = null;
    _selectedProduct = null;
    previousShotTimesController.clear();
    previousBottleQuantityController.clear();
    presentShotTimesController.clear();
    presentBottleQuantityController.clear();
    presentHourlyCapacityController.clear();
    wastageBottleController.clear();

    FocusScope.of(context).unfocus();
    showSnackbar(context, 'All fields data cleared!');
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  String? inputValidation(value, context) {
    if (value == null || value.isEmpty) {
      return '* required';
    }

    final isInteger = RegExp(r'^[0-9]+$').hasMatch(value);
    if (!isInteger) {
      return 'Enter numeric data';
    }

    return null;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
