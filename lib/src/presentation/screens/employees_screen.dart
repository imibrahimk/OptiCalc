import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../data/employees_data.dart';
import '../../routes/route_pages.dart';
import '../widgets/circular_photo.dart';
import 'flip_card_screen.dart';

class EmployeesScreen extends StatelessWidget {
  EmployeesScreen({super.key});

  final borderRadius = BorderRadius.circular(50.0);

  final employeeData = EmployeesData.employeeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PET Bottle's Employee",
          style: TextStyle(
            fontSize: 18.0.sp,
            color: Colors.orange.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.homeScreen),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: employeeData.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.h),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: ListTile(
              // tileColor: Colors.blue.shade50,
              leading: CircularPhoto(
                photo: '${employeeData[index]['photo']}',
                borderRadius: borderRadius,
              ),
              title: Text('${employeeData[index]['name']}', maxLines: 1),
              subtitle: Text('${employeeData[index]['designation']}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      FlipCardScreen(data: employeeData[index]),
                ));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
