import 'package:flutter/material.dart';

import '../calculation/downtime_calc.dart';

class DowntimeProvider with ChangeNotifier {
  String? productionHours;
  String? machineDowntime;

  final GlobalKey<FormState> planHoursFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> hourlyCapacityFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> producedQuantityFormKey = GlobalKey<FormState>();

  final TextEditingController planHoursController = TextEditingController();
  final TextEditingController hourlyCapacityController =
      TextEditingController();
  final TextEditingController producedQuantityController =
      TextEditingController();

  void calculate(context) {
    if (planHoursController.text.isEmpty) {
      showSnackbar(context, 'Please enter plan hours');
      return;
    }

    if (hourlyCapacityController.text.isEmpty) {
      showSnackbar(context, 'Please enter hourly capacity');
      return;
    }
    if (producedQuantityController.text.isEmpty) {
      showSnackbar(context, 'Please enter produced quantity');
      return;
    }

    final DowntimeCalc calculate = DowntimeCalc(
      planHours: int.parse(planHoursController.text),
      hourlyCapacity: int.parse(hourlyCapacityController.text),
      producedQuantity: int.parse(producedQuantityController.text),
    );

    productionHours = calculate.calculateProductionHours();
    machineDowntime = calculate.calculateDowntime();

    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void resetFields(context) {
    productionHours = null;
    machineDowntime = null;

    planHoursController.clear();
    hourlyCapacityController.clear();
    producedQuantityController.clear();

    FocusScope.of(context).unfocus();
    showSnackbar(context, 'All fields data cleared!');

    notifyListeners();
  }

  // Show snackBar message
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Validate the input string against the integer
  bool validateInt(String value) {
    final regex = RegExp(r'^\d+$');
    return regex.hasMatch(value);
  }
}
