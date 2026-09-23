import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class GradientBorderBox extends StatelessWidget {
  const GradientBorderBox({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
  });

  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  static const double _borderWidth = 0.4;

  static const LinearGradient _borderGradient = LinearGradient(
    transform: GradientRotation(89.85 * math.pi / 180),
    colors: <Color>[
      AppColors.white,
      AppColors.textFieldBorderMid,
      AppColors.white,
    ],
    stops: <double>[0.0009, 0.5673, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? 14.r;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: _borderGradient,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.textFieldCardShadow,
            offset: Offset(0, 3.h),
            blurRadius: 4.8.r,
          ),
        ],
      ),
      padding: const EdgeInsets.all(_borderWidth),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius - _borderWidth),
          color: AppColors.textFieldCardBackground,
        ),
        child: padding != null ? Padding(padding: padding!, child: child) : child,
      ),
    );
  }
}
