import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/text_stf.dart';

// ignore: must_be_immutable
class DowntimeScreen extends StatelessWidget {
  DowntimeScreen({super.key});

  String? machineDowntime;
  String? productionHour;

  final TextEditingController planHourController = TextEditingController();
  final TextEditingController hourlyCapacityController =
      TextEditingController();
  final TextEditingController producedQuantityController =
      TextEditingController();

  final GlobalKey<FormState> _planHourKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hourlyCapacityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _producedQuantityKey = GlobalKey<FormState>();

  final GlobalKey<TextStfState> _myTextViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Downtime'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(17.0.dm),
        child: Column(
          children: [
            Form(
              key: _planHourKey,
              child: TextFormField(
                controller: planHourController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Enter plan hour',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0.dm,
            ),
            Form(
              key: _hourlyCapacityKey,
              child: TextFormField(
                controller: hourlyCapacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter hourly capacity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0.dm,
            ),
            Form(
              key: _producedQuantityKey,
              child: TextFormField(
                controller: producedQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter produced quantity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0.dm,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (planHourController.text.isEmpty) {
                        showToast('Please enter your plan hour');
                        return;
                      }

                      if (hourlyCapacityController.text.isEmpty) {
                        showToast('Please enter hourly capacity');
                        return;
                      }
                      if (producedQuantityController.text.isEmpty) {
                        showToast('Please enter produced quantity');
                        return;
                      }
                      getProductionHour();
                      getDowntime();
                      // Update MyTextView using the GlobalKey
                      _myTextViewKey.currentState?.updateText(
                        "Production Hours: $productionHour\nMachine Downtime: $machineDowntime",
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calculate_outlined),
                        SizedBox(width: 8.0.w),
                        const Text('Calculate'),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      planHourController.clear();
                      hourlyCapacityController.clear();
                      producedQuantityController.clear();

                      productionHour = null;
                      machineDowntime = null;

                      // Update MyTextView using the GlobalKey
                      _myTextViewKey.currentState?.updateText(
                        "Production Hours:\nMachine Downtime:",
                      );

                      showToast('All fields data cleared!');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.clear_all_outlined),
                        SizedBox(width: 8.0.w),
                        const Text('Clear'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0.dm,
            ),
            Container(
              padding: EdgeInsets.all(12.0.dm),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0.w),
                  borderRadius: BorderRadius.circular(8.0.r)),
              child: TextStf(
                  key: _myTextViewKey,
                  text: 'Production Hours:\nMachine Downtime:'),
            )
          ],
        ),
      ),
    );
  }

  void getProductionHour() {
    int producedQuantity = int.parse(producedQuantityController.text);
    double remainingRuntime =
        producedQuantity / int.parse(hourlyCapacityController.text);

    int hours = remainingRuntime.floor();
    int minutes = ((remainingRuntime * 60) % 60).round();

    String productionHoursFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    productionHour = productionHoursFormatted;
  }

  void getDowntime() {
    int producedQuantity = int.parse(producedQuantityController.text);
    int planDuration = int.parse(planHourController.text);

    int expectedProduction =
        int.parse(hourlyCapacityController.text) * planDuration;

    double downtime = ((expectedProduction - producedQuantity) /
        int.parse(hourlyCapacityController.text));

    int hours = downtime.floor();
    int minutes = ((downtime * 60) % 60).round();

    String downtimeFormatted =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    machineDowntime = downtimeFormatted;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
  }
}
