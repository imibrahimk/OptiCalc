class DowntimeCalc {
  int planHours;
  int hourlyCapacity;
  int producedQuantity;

  DowntimeCalc({
    required this.planHours,
    required this.hourlyCapacity,
    required this.producedQuantity,
  });

  // Calculate production hours
  String calculateProductionHours() {
    double remainingRuntime = producedQuantity / hourlyCapacity;

    String productionHoursFormatted = formatHHMM(remainingRuntime);
    return productionHoursFormatted;
  }

  // Calculate machine downtime hours
  String calculateDowntime() {
    int expectedProduction = hourlyCapacity * planHours;
    double downtime = (expectedProduction - producedQuantity) / hourlyCapacity;

    String downtimeFormatted = formatHHMM(downtime);
    return downtimeFormatted;
  }

  // Get formatted in HH:MM
  String formatHHMM(remainingTime) {
    int hours = remainingTime.floor();
    int minutes = ((remainingTime * 60) % 60).round();

    String formattedHHMM =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return formattedHHMM;
  }
}
