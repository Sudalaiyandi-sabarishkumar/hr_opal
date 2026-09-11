import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../badges/app_badge.dart' show AppBadgeColor;

enum AppChipVariant { solid, soft, subtle, outline }

enum AppChipSize { large, medium, small }

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color = AppBadgeColor.info,
    this.variant = AppChipVariant.solid,
    this.size = AppChipSize.large,
    this.showLeadingDot = true,
    this.showTrailingDot = true,
  });

  final String label;
  final AppBadgeColor color;
  final AppChipVariant variant;
  final AppChipSize size;
  final bool showLeadingDot;
  final bool showTrailingDot;

  Color get _base => switch (color) {
    AppBadgeColor.info => AppColors.statusInfo,
    AppBadgeColor.neutral => AppColors.statusNeutral,
    AppBadgeColor.success => AppColors.statusSuccess,
    AppBadgeColor.warning => AppColors.statusWarning,
    AppBadgeColor.danger => AppColors.statusDanger,
  };

  Color get _background => switch (variant) {
    AppChipVariant.solid => _base,
    AppChipVariant.outline => AppColors.white,
    AppChipVariant.soft =>
      color == AppBadgeColor.info ? AppColors.statusInfoSoft : AppColors.statusSoftBg,
    AppChipVariant.subtle => switch (color) {
      AppBadgeColor.info => AppColors.statusInfoSoft,
      AppBadgeColor.neutral => AppColors.statusNeutralSubtleBg,
      AppBadgeColor.success => AppColors.statusSuccessSubtleBg,
      AppBadgeColor.warning => AppColors.statusWarningSubtleBg,
      AppBadgeColor.danger => AppColors.statusDangerSubtleBg,
    },
  };

  Color get _foreground => switch (variant) {
    AppChipVariant.solid => AppColors.white,
    AppChipVariant.soft ||
    AppChipVariant.subtle ||
    AppChipVariant.outline => switch (color) {
      AppBadgeColor.info => AppColors.statusInfo,
      AppBadgeColor.neutral => AppColors.statusNeutralText,
      AppBadgeColor.success => AppColors.statusSuccessText,
      AppBadgeColor.warning => AppColors.statusWarningText,
      AppBadgeColor.danger => AppColors.statusDangerText,
    },
  };

  double get _radius => switch (size) {
    AppChipSize.large => 16.r,
    AppChipSize.medium => 12.r,
    AppChipSize.small => 12.r,
  };

  EdgeInsets get _padding => switch (size) {
    AppChipSize.large =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    AppChipSize.medium =>
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    AppChipSize.small => EdgeInsets.symmetric(horizontal: 4.w),
  };

  double get _dotSize => switch (size) {
    AppChipSize.large => 12.r,
    AppChipSize.medium => 10.r,
    AppChipSize.small => 9.r,
  };

  static const double _gap = 2;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle labelStyle = switch (size) {
      AppChipSize.large => textTheme.geist14Medium,
      AppChipSize.medium => textTheme.geist12Medium,
      AppChipSize.small => textTheme.geist12Medium,
    }.copyWith(color: _foreground);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showLeadingDot) ...<Widget>[
              _dot,
              SizedBox(width: _gap.w),
            ],
            Text(label, style: labelStyle),
            if (showTrailingDot) ...<Widget>[
              SizedBox(width: _gap.w),
              _dot,
            ],
          ],
        ),
      ),
    );
  }

  Widget get _dot => Container(
    width: _dotSize,
    height: _dotSize,
    decoration: BoxDecoration(color: _foreground, shape: BoxShape.circle),
  );
}
