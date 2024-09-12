class Calculations {
  String? selectedPlan;
  String? selectedProduct;
  int? prevShotTimes;
  int? prevBottleQuantity;
  int? prsShotTimes;
  int? prsBottleQuantity;
  int? hourlyCapacity;
  int? wastageBottle;

  Calculations(
    this.selectedPlan,
    this.selectedProduct,
    this.prevShotTimes,
    this.prevBottleQuantity,
    this.prsShotTimes,
    this.prsBottleQuantity,
    this.hourlyCapacity,
    this.wastageBottle,
  );

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

  int calculateCavity() {
    final cavity = switch (selectedProduct!.toUpperCase()) {
      "500 ML" => 8,
      "1000 ML" => 8,
      "1500 ML" => 6,
      "2000 ML" => 6,
      _ => 0,
    };
    return cavity;
  }

  double calculatePreformWeight() {
    final preformWeight = switch (selectedProduct!.toUpperCase()) {
      "500 ML" => 18.44,
      "1000 ML" => 32.5,
      "1500 ML" => 50.2,
      "2000 ML" => 50.2,
      _ => 0.0,
    };
    return preformWeight;
  }

  int calculateTotalShot() {
    if (prsShotTimes != null && prevShotTimes != null) {
      int totalShots = prsShotTimes! - prevShotTimes!;
      return totalShots;
    }
    return 0;
  }

  int calculateTotalBottle() {
    if (prsBottleQuantity != null && prevBottleQuantity != null) {
      int totalBottles = prsBottleQuantity! - prevBottleQuantity!;
      return totalBottles;
    }
    return 0;
  }

  int calculateWastagePreform() {
    int totalShots = calculateTotalShot();
    int bottle = calculateTotalBottle();
    int cavity = calculateCavity();
    int totalPreform = totalShots * cavity;
    int wastagePreform = totalPreform - bottle;
    return wastagePreform;
  }

  int calculateWellBottle() {
    int totalBottles = calculateTotalBottle();
    if (wastageBottle != null) {
      totalBottles = totalBottles - wastageBottle!;
      return totalBottles;
    }
    return totalBottles;
  }

  double calculateUsedRawMaterial() {
    double preformWeight = calculatePreformWeight();
    int totalShots = calculateTotalShot();
    int cavity = calculateCavity();
    int preform = totalShots * cavity;
    double usedRawMaterial = preform * preformWeight / 1000;
    return usedRawMaterial;
  }

  String calculateProductionHours() {
    int producedQuantity = calculateTotalBottle();
    double remainingRuntime = producedQuantity / hourlyCapacity!;

    int hours = remainingRuntime.floor();
    int minutes = ((remainingRuntime * 60) % 60).round();

    String productionHoursFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return productionHoursFormatted;
  }

  String calculateMachineDowntime() {
    int producedQuantity = calculateTotalBottle();
    int planDuration = calculatePlanDuration();

    int expectedProduction = hourlyCapacity! * planDuration;
    double downtime =
        ((expectedProduction - producedQuantity) / hourlyCapacity!);

    int hours = downtime.floor();
    int minutes = ((downtime * 60) % 60).round();

    String downtimeFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return downtimeFormatted;
  }

  double calculateMachineEfficiency() {
    double efficiency = 0.0;

    int producedQuantity = calculateTotalBottle();
    int maxExpectedProduction = calculateExpectedProduction();

    efficiency = (producedQuantity / maxExpectedProduction) * 100;

    return efficiency;
  }

  int calculateExpectedProduction() {
    int maxHourlyCapacity = calculateHourlyMaxCapacity();
    double prodHours = convertTimeStringToHours();
    int expectedProd = (maxHourlyCapacity * prodHours).toInt();
    return expectedProd;
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
}
