class EfficiencyCalc {
  String selectedPlan;
  String selectedProduct;
  String machineDowntime;
  int producedBottleQuantity;

  EfficiencyCalc({
    required this.selectedPlan,
    required this.selectedProduct,
    required this.machineDowntime,
    required this.producedBottleQuantity,
  });

  int getPlanDuration() {
    final planDuration = switch (selectedPlan.toUpperCase()) {
      "08 HOURS" => 8,
      "12 HOURS" => 12,
      "16 HOURS" => 16,
      "24 HOURS" => 24,
      _ => 0,
    };
    return planDuration;
  }

  int getMaxHourlyCapacity() {
    final maxHourlyCapacity = switch (selectedProduct.toUpperCase()) {
      "500 ML" => 2400,
      "1000 ML" => 1920,
      "1500 ML" => 1200,
      "2000 ML" => 1200,
      _ => 0,
    };
    return maxHourlyCapacity;
  }

  double calculateProductionHours(int planHours, String machineDowntime) {
    if (machineDowntime.isEmpty) {
      return planHours.toDouble();
    }

    // Parse breakdown time (ensure correct format)
    List<String> parts = machineDowntime.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid breakdown time format. Please use HH:MM.');
    }

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Validate breakdown time
    if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
      throw ArgumentError('Invalid breakdown time values.');
    }

    // Calculate breakdown hours in decimal format
    double breakdownHours = hours + (minutes / 60.0);

    return planHours - breakdownHours;
  }

  int calculateExpectedProduction() {
    // Calculate maximum hourly capacity based on selected product
    int maxHourlyCapacity = getMaxHourlyCapacity();
    // Calculate total production hours based on selected plan and machine downtime
    int planHours = getPlanDuration();
    double productionHours =
        calculateProductionHours(planHours, machineDowntime);
    // Calculate expected production
    int expectedProduction = (maxHourlyCapacity * productionHours).round();
    return expectedProduction;
  }

  double calculateMachineEfficiency() {
    int expectedProduction = calculateExpectedProduction();
    if (expectedProduction == 0) {
      return 0.0;
    }

    return (producedBottleQuantity / expectedProduction) * 100;
  }
}
