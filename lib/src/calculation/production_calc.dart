class ProductionCalc {
  String? selectedPlan;
  String? selectedProduct;
  int? presentShotCounter;
  int? presentBottleCounter;
  int? previousShotCounter;
  int? previousBottleCounter;
  int? presentHourlyBottleProduction;
  int? wastageBottleQuantity;

  ProductionCalc(
      {this.selectedPlan,
      this.selectedProduct,
      this.presentShotCounter,
      this.presentBottleCounter,
      this.previousShotCounter,
      this.previousBottleCounter,
      this.presentHourlyBottleProduction,
      this.wastageBottleQuantity});

  int calculatePlanDuration() {
    final planDuration = switch (selectedPlan!.toUpperCase()) {
      "08 HOURS" => 8,
      "12 HOURS" => 12,
      "16 HOURS" => 16,
      "24 HOURS" => 24,
      _ => 0,
    };
    return planDuration;
  }

  int calculateNumOfCavity() {
    final cavity = switch (selectedProduct!.toUpperCase()) {
      "500 ML" => 8,
      "1000 ML" => 8,
      "1500 ML" => 6,
      "2000 ML" => 6,
      _ => 0,
    };
    return cavity;
  }

  double calculatePreformsWeight() {
    final preformsWeight = switch (selectedProduct!.toUpperCase()) {
      "500 ML" => 18.44,
      "1000 ML" => 32.5,
      "1500 ML" => 50.2,
      "2000 ML" => 50.2,
      _ => 0.0,
    };
    return preformsWeight;
  }

  int calculateHourlyMaxCapacity() {
    final hourlyMaxCapacity = switch (selectedProduct!.toUpperCase()) {
      "500 ML" => 2400,
      "1000 ML" => 1920,
      "1500 ML" => 1200,
      "2000 ML" => 1200,
      _ => 0,
    };
    return hourlyMaxCapacity;
  }

  int calculateTotalShotTimes() {
    int totalShotTimes = presentShotCounter! - previousShotCounter!;
    return totalShotTimes;
  }

  int calculateTotalBottleQuantity() {
    int totalBottleQuantity = presentBottleCounter! - previousBottleCounter!;
    return totalBottleQuantity;
  }

  int calculateWellBottleQuantity() {
    int wellBottleQuantity = calculateTotalBottleQuantity();
    if (wastageBottleQuantity != null) {
      wellBottleQuantity = wellBottleQuantity - wastageBottleQuantity!;
      return wellBottleQuantity;
    }
    return wellBottleQuantity;
  }

  int calculateWastagePreform() {
    int totalShots = calculateTotalShotTimes();
    int bottle = calculateTotalBottleQuantity();
    int numOfCavity = calculateNumOfCavity();
    int totalPreform = totalShots * numOfCavity;
    int wastagePreform = totalPreform - bottle;
    return wastagePreform;
  }

  double calculateUsedRawMaterial() {
    double preformWeight = calculatePreformsWeight();
    int totalShots = calculateTotalShotTimes();
    int cavity = calculateNumOfCavity();
    int preform = totalShots * cavity;
    double usedRawMaterial = preform * preformWeight / 1000;
    return usedRawMaterial;
  }

  int calculateExpectedProduction() {
    int maxHourlyCapacity = calculateHourlyMaxCapacity();
    double prodHours = convertTimeStringToHours();
    int expectedProduction = (maxHourlyCapacity * prodHours).toInt();
    return expectedProduction;
  }

  double convertTimeStringToHours() {
    double hours = 0.0;
    String timeString = calculateProductionHours();
    if (timeString.contains(":")) {
      List<String> parts = timeString.split(":");
      int hoursPart = int.parse(parts[0]);
      int minutesPart = int.parse(parts[1]);
      hours = hoursPart + (minutesPart / 60.0);
    }
    return hours;
  }

  String calculateProductionHours() {
    int producedBottleQuantity = calculateTotalBottleQuantity();
    double remainingRuntime =
        producedBottleQuantity / presentHourlyBottleProduction!;

    int hours = remainingRuntime.floor();
    int minutes = ((remainingRuntime * 60) % 60).round();

    String productionHoursFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return productionHoursFormatted;
  }

  String calculateMachineDowntime() {
    int producedQuantity = calculateTotalBottleQuantity();
    int planDuration = calculatePlanDuration();

    int expectedProduction = presentHourlyBottleProduction! * planDuration;
    double downtime = ((expectedProduction - producedQuantity) /
        presentHourlyBottleProduction!);

    int hours = downtime.floor();
    int minutes = ((downtime * 60) % 60).round();

    String downtimeFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return downtimeFormatted;
  }

  double calculateMachineEfficiency() {
    double efficiency = 0.0;

    int producedQuantity = calculateTotalBottleQuantity();
    int maxExpectedProduction = calculateExpectedProduction();

    efficiency = (producedQuantity / maxExpectedProduction) * 100;

    return efficiency;
  }
}
