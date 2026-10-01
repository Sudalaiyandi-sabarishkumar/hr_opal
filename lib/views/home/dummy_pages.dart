import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Simple placeholder used by every dummy page.
class _DummyPage extends StatelessWidget {
  const _DummyPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF16161D),
      ),
      body: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// Bottom tab pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => const _DummyPage(title: 'Home');
}

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});
  @override
  Widget build(BuildContext context) => const _DummyPage(title: 'Attendance');
}
