import 'package:flutter/material.dart';

import '../calculation/efficiency_calc.dart';

class EfficiencyProvider with ChangeNotifier {
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

  String? machineEfficiency;
  int? maxExpectedProduction;

  String? _selectedPlan;
  String? _selectedProduct;

  String? get selectedPlan => _selectedPlan;
  String? get selectedProduct => _selectedProduct;

  final TextEditingController machineDowntimeController =
      TextEditingController();
  final TextEditingController producedBottleQuantityController =
      TextEditingController();

  // Update selected value from dropdown
  void updateSelectedPlanValue(String? newValue) {
    _selectedPlan = newValue;
    notifyListeners();
  }

  void updateSelectedProductValue(String? newValue) {
    _selectedProduct = newValue;
    notifyListeners();
  }

  // Calculate machine efficiency
  void calculate(context) {
    if (_selectedPlan == null) {
      showSnackbar(context, 'Please select a plan');
      return;
    } else if (_selectedProduct == null) {
      showSnackbar(context, 'Please select a product');
      return;
    } else if (machineDowntimeController.text.isEmpty) {
      showSnackbar(context, 'Please enter downtime');
      return;
    } else if (producedBottleQuantityController.text.isEmpty) {
      showSnackbar(context, 'Please enter produced bottle');
      return;
    } else {
      EfficiencyCalc calculate = EfficiencyCalc(
        selectedPlan: _selectedPlan!,
        selectedProduct: _selectedProduct!,
        machineDowntime: machineDowntimeController.text,
        producedBottleQuantity:
            int.parse(producedBottleQuantityController.text),
      );

      machineEfficiency =
          calculate.calculateMachineEfficiency().toStringAsFixed(2);
      maxExpectedProduction = calculate.calculateExpectedProduction();
      notifyListeners();
    }
  }

  // Clear all input fields
  void resetFields() {
    _selectedPlan = null;
    _selectedProduct = null;
    machineDowntimeController.clear();
    producedBottleQuantityController.clear();
    machineEfficiency = null;
    maxExpectedProduction = null;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Validate the input string against the HH:MM format
  bool validateHHMM(String input) {
    final regex = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');
    return regex.hasMatch(input);
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
