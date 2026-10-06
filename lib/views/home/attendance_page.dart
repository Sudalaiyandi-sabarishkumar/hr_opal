import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Simple placeholder used by every dummy page.
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key,});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF16161D),
      ),
      body: Center(
        child: Text(
          'Attendance Page',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
