import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';


class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    required this.title,
    required this.headerColor,
    required this.child,
  });

  
  final String title;

  
  final Color headerColor;


  final Widget child;

  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(_radius.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 53.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_radius.r),
                topRight: Radius.circular(_radius.r),
              ),
            ),
            child: Text(
              title,
              style: textTheme.geist14Regular.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            child: child,
          ),
        ],
      ),
    );
  }
}


class AppStackedInfoRow extends StatelessWidget {
  const AppStackedInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: textTheme.geist13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: 16.r, color: AppColors.textPrimary),
              SizedBox(width: 6.w),
            ],
            Expanded(
              child: Text(
                value,
                style: textTheme.geist14Regular.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
