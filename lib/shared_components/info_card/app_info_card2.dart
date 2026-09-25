import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';



/// Generic rounded, bordered card shell reused by every history/list
/// card (Amendments, Requests History, ...). Pass a [header] slot for
/// the top (colored) section and a [body] slot for the detail rows.
class AppInfoCard2 extends StatelessWidget {
  const AppInfoCard2({
    super.key,
    required this.header,
    required this.body,
    this.headerColor = AppColors.white,
  });

  final Widget header;
  final Widget body;
  final Color headerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: headerColor,
            padding: EdgeInsets.all(16.r),
            child: header,
          ),
          const Divider(color: AppColors.neutral200, height: 1),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: body,
          ),
        ],
      ),
    );
  }
}

/// A single "label ......... value" line, label left / value right,
/// used for the Amendments detail rows.
class LabelValueRow extends StatelessWidget {
  const LabelValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.neutral300,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.statusNeutralText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A "label" above "value" block, used for the Requests History grid
/// (stacked layout, laid out 1-up or N-up by the caller).
class LabeledValueBlock extends StatelessWidget {
  const LabeledValueBlock({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: textTheme.geist13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: textTheme.geist13Regular.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Small rounded pill used for tags like "Personal Loan", "Bank
/// Account", or as the "New Company" / "New Designation" value style.
class AppTagChip extends StatelessWidget {
  const AppTagChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: textTheme.geist12Regular.copyWith(color: foreground),
      ),
    );
  }
}

/// Dot + text status indicator, e.g. "• Active".
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.color = AppColors.accordionGreenFg,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.white,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: textTheme.geist12Medium.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

/// Circular accent icon used between the "old" and "new" values on an
/// Amendments card (double-chevron in a tinted circle).
class AppAccentCircleIcon extends StatelessWidget {
  const AppAccentCircleIcon({
    super.key,
    required this.background,
    required this.foreground,
    this.icon = Icons.keyboard_double_arrow_right_rounded,
  });

  final Color background;
  final Color foreground;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 21.r,
      height: 21.r,
      decoration: BoxDecoration(shape: BoxShape.circle, color: background),
      child: Icon(icon, size: 16.r, color: foreground),
    );
  }
}
