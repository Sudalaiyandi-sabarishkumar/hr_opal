import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightBlueAccent,
      error: Colors.redAccent
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
    titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
    titleSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
    bodyLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
    bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
    bodySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
  ),
);
