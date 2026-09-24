import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

/// A single reusable option tile row with leading icon, label, and trailing chevron.
/// Sits transparently inside [AppOptionCard].
class AppOptionTile extends StatelessWidget {
  const AppOptionTile({
    super.key,
    this.icon,
    this.svgAsset,
    required this.label,
    this.onTap,
    this.iconColor,
    this.labelColor,
    this.labelStyle,
    this.showTrailingIcon = true,
    this.trailingIcon,
    this.backgroundColor = AppColors.transparent,
  }) : assert(icon != null || svgAsset != null, 'Either icon or svgAsset must be provided');

  /// Leading icon shown at the start of the row.
  final IconData? icon;

  /// Leading SVG asset path shown at the start of the row.
  final String? svgAsset;

  /// Row label.
  final String label;

  /// Called when the row is tapped. When null the row is not interactive.
  final VoidCallback? onTap;

  /// Overrides the default leading icon color.
  final Color? iconColor;

  /// Overrides the default label color.
  final Color? labelColor;

  /// Overrides the default label text style.
  final TextStyle? labelStyle;

  /// Whether to show the trailing chevron / icon. Defaults to true.
  final bool showTrailingIcon;

  /// Overrides the default trailing chevron icon.
  final IconData? trailingIcon;

  /// Optional background color of the tile. Defaults to [AppColors.transparent].
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: <Widget>[
              if (svgAsset != null)
                SvgPicture.asset(
                  svgAsset!,
                  width: 20.r,
                  height: 20.r,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      : null,
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 20.r,
                  color: iconColor ?? AppColors.neutral700,
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style:
                      labelStyle ??
                      textTheme.geist14Regular.copyWith(
                        color: labelColor ?? AppColors.textPrimary,
                      ),
                ),
              ),
              if (showTrailingIcon) ...<Widget>[
                SizedBox(width: 8.w),
                Icon(
                  trailingIcon ?? Icons.chevron_right_rounded,
                  size: 20.r,
                  color: AppColors.neutral300,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A container card that groups a list of [AppOptionTile]s (e.g. "Profile Details", "Settings").
///
/// Features:
/// - Background: `#ECECEC33` (pure fill without gradient bleeding into interior)
/// - Border: 0.4px stroke with `linear-gradient(89.85deg, #FFFFFF 0.13%, #BCC7E4 80.55%, #FFFFFF 141.98%)`
/// - Box Shadow: `0px 3px 4.8px 0px #FFFFFF14`
class AppOptionCard extends StatelessWidget {
  const AppOptionCard({
    super.key,
    required this.tiles,
    this.showDividers = false,
    this.borderRadius,
    this.margin,
  });

  final List<AppOptionTile> tiles;
  final bool showDividers;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  static const double _borderWidth = 0.4;

  static const LinearGradient _borderGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFBCC7E4),
      Color(0xFFFFFFFF),
    ],
    stops: <double>[0.0013, 0.8055, 1.0],
  );

  static const Color _backgroundColor = Color(0x33ECECEC);

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? 16.r;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0x14FFFFFF),
            offset: Offset(0, 3.h),
            blurRadius: 4.8.r,
          ),
        ],
      ),
      child: CustomPaint(
        foregroundPainter: _GradientBorderPainter(
          radius: radius,
          borderWidth: _borderWidth,
          gradient: _borderGradient,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            color: _backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i < tiles.length; i++) ...<Widget>[
                  tiles[i],
                  if (showDividers && i != tiles.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 16.w,
                      endIndent: 16.w,
                      color: AppColors.neutral100,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  const _GradientBorderPainter({
    required this.radius,
    required this.borderWidth,
    required this.gradient,
  });

  final double radius;
  final double borderWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final RRect strokeRRect = rrect.deflate(borderWidth / 2);

    final Paint strokePaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(strokeRRect, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.gradient != gradient;
  }
}