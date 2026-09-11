import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

enum AppBadgeColor { info, neutral, success, warning, danger }

enum AppBadgeVariant { solid, soft, subtle }

enum AppBadgeSize { large, medium, small }

enum AppBadgeTrailing { none, icon, dot }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.color = AppBadgeColor.info,
    this.variant = AppBadgeVariant.solid,
    this.size = AppBadgeSize.large,
    this.showLeadingIcon = true,
    this.trailing = AppBadgeTrailing.none,
  });

  final String label;
  final AppBadgeColor color;
  final AppBadgeVariant variant;
  final AppBadgeSize size;
  final bool showLeadingIcon;
  final AppBadgeTrailing trailing;

  Color get _base => switch (color) {
    AppBadgeColor.info => AppColors.statusInfo,
    AppBadgeColor.neutral => AppColors.statusNeutral,
    AppBadgeColor.success => AppColors.statusSuccess,
    AppBadgeColor.warning => AppColors.statusWarning,
    AppBadgeColor.danger => AppColors.statusDanger,
  };

  Color get _background => switch (variant) {
    AppBadgeVariant.solid => _base,
    AppBadgeVariant.soft =>
      color == AppBadgeColor.info ? AppColors.statusInfoSoft : AppColors.statusSoftBg,
    AppBadgeVariant.subtle => switch (color) {
      AppBadgeColor.info => AppColors.statusInfoSoft,
      AppBadgeColor.neutral => AppColors.statusNeutralSubtleBg,
      AppBadgeColor.success => AppColors.statusSuccessSubtleBg,
      AppBadgeColor.warning => AppColors.statusWarningSubtleBg,
      AppBadgeColor.danger => AppColors.statusDangerSubtleBg,
    },
  };

  Color get _foreground => switch (variant) {
    AppBadgeVariant.solid => AppColors.white,
    AppBadgeVariant.soft || AppBadgeVariant.subtle => switch (color) {
      AppBadgeColor.info => AppColors.statusInfo,
      AppBadgeColor.neutral => AppColors.statusNeutralText,
      AppBadgeColor.success => AppColors.statusSuccessText,
      AppBadgeColor.warning => AppColors.statusWarningText,
      AppBadgeColor.danger => AppColors.statusDangerText,
    },
  };

  double get _iconSize => switch (size) {
    AppBadgeSize.large => 14.r,
    AppBadgeSize.medium => 10.r,
    AppBadgeSize.small => 9.r,
  };

  double get _gap => switch (size) {
    AppBadgeSize.large => 2.w,
    AppBadgeSize.medium => 2.w,
    AppBadgeSize.small => 2.w,
  };

  EdgeInsets get _padding => switch (size) {
    AppBadgeSize.large =>
      EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
    AppBadgeSize.medium =>
      EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
    AppBadgeSize.small =>
      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
  };

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle labelStyle = switch (size) {
      AppBadgeSize.large => textTheme.geist14Medium,
      AppBadgeSize.medium => textTheme.geist12Medium,
      AppBadgeSize.small => textTheme.geist10Medium,
    }.copyWith(color: _foreground);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: _background,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showLeadingIcon) ...<Widget>[
              Icon(Icons.info_outline, size: _iconSize, color: _foreground),
              SizedBox(width: _gap),
            ],
            Text(label, style: labelStyle),
            if (trailing != AppBadgeTrailing.none) ...<Widget>[
              SizedBox(width: _gap),
              _trailingWidget,
            ],
          ],
        ),
      ),
    );
  }

  Widget get _trailingWidget => switch (trailing) {
    AppBadgeTrailing.dot => Container(
      width: _iconSize * 0.6,
      height: _iconSize * 0.6,
      decoration: BoxDecoration(color: _foreground, shape: BoxShape.circle),
    ),
    _ => Icon(Icons.info_outline, size: _iconSize, color: _foreground),
  };
}
