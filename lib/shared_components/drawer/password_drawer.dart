import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../button/custom_button.dart';

class PasswordDrawer extends StatelessWidget {
  const PasswordDrawer({
    super.key,
    required this.placement,
    required this.title,
    required this.body,
    this.onClose,
    this.onCancel,
    this.width,
    this.height,
    this.showHandle,
    this.icon,
    this.backgroundImage,
    this.closeButtonLabel = 'Close',
    this.primaryButtonLabel,
    this.onPrimaryTap,
    this.margin,
    this.borderColor = AppColors.neutral300,
    this.borderWidth = 1,
    this.borderRadius,
  });

  final AppDrawerPlacement placement;
  final String title;
  final String body;

  final VoidCallback? onClose;
  final VoidCallback? onCancel;
  final double? width;
  final double? height;
  final String? icon;
  final bool? showHandle;

  /// Decorative SVG drawn behind the icon/title/body, clipped to the
  /// drawer's own corner radius and scaled to cover the whole card
  /// (matches the faint striped/gradient backdrop behind the checkmark
  /// in the "Password Reset!" style drawer).
  final String? backgroundImage;

  /// Label for the always-present outline button (defaults to "Close").
  final String closeButtonLabel;

  /// When provided, a second filled button is shown next to the close
  /// button (e.g. "Back to Sign In"). When null, only the single
  /// full-width close button is shown, same as before.
  final String? primaryButtonLabel;
  final VoidCallback? onPrimaryTap;

  /// Space between the drawer card and the screen edges. When null, a
  /// sensible default is used: for top/bottom placements the card floats
  /// off the left, right, and top/bottom screen edges (16.w / 16.h);
  /// for left/right placements the card still sits flush against its own
  /// screen edge, as before (zero margin), since only one side is a "free"
  /// edge to round off.
  final EdgeInsets? margin;

  /// Stroke drawn along the bottom, left, and right edges of the card
  /// (the top edge is left borderless, e.g. so it reads as continuous
  /// with the handle/header area above it).
  final Color borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;

  bool get _isHorizontalEdge =>
      placement == AppDrawerPlacement.top ||
      placement == AppDrawerPlacement.bottom;

  EdgeInsets get _effectiveMargin {
    if (margin != null) {
      return margin!;
    }
    if (!_isHorizontalEdge) {
      return EdgeInsets.zero;
    }
    return EdgeInsets.only(
      left: 16.w,
      right: 16.w,
      top: placement == AppDrawerPlacement.top ? 16.h : 0,
      bottom: placement == AppDrawerPlacement.bottom ? 16.h : 0,
    );
  }

  BorderRadius _radius(double r) {
    if (borderRadius != null) {
      return borderRadius!;
    }
    final EdgeInsets m = _effectiveMargin;
    return switch (placement) {
      AppDrawerPlacement.top =>
        m.top > 0 ? BorderRadius.circular(r) : BorderRadius.vertical(bottom: Radius.circular(r)),
      AppDrawerPlacement.bottom => BorderRadius.circular(r),
      AppDrawerPlacement.left =>
        m.left > 0 ? BorderRadius.circular(r) : BorderRadius.horizontal(right: Radius.circular(r)),
      AppDrawerPlacement.right =>
        m.right > 0 ? BorderRadius.circular(r) : BorderRadius.horizontal(left: Radius.circular(r)),
    };
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool handle = showHandle ?? placement == AppDrawerPlacement.bottom;
    final BorderRadius radius = _radius(24.r);

    return Container(
      margin: _effectiveMargin,
      width: _isHorizontalEdge ? double.infinity : (width ?? 320.w),
      height: _isHorizontalEdge ? null : height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        // Shadow lives on this outer, unclipped Container so the inner
        // ClipRRect below can safely clip the background SVG to the
        // rounded corners without also clipping (and hiding) the shadow.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
          BoxShadow(
            color: AppColors.modalShadowAmbient,
            blurRadius: 28.r,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: <Widget>[
            if (backgroundImage != null)
              Positioned.fill(
                child: SvgPicture.asset(
                  AppAssets.bg3Image,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize:
                    _isHorizontalEdge ? MainAxisSize.min : MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (handle)
                    Center(
                      child: Container(
                        width: 36.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.neutral300,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  if (icon != null) ...<Widget>[
                    SvgPicture.asset(icon!, width: 41.r, height: 41.r),
                    SizedBox(height: 16.h),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          style: textTheme.geist18SemiBold.copyWith(
                            color: AppColors.textPrimary,
                            fontFamily: hostGroteskFont,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    body,
                    style: textTheme.geist14Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (!_isHorizontalEdge) const Spacer(),
                  SizedBox(height: 20.h),
                  if (primaryButtonLabel != null)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomButton(
                            buttonName: closeButtonLabel,
                            variant: AppButtonVariant.outline,
                            size: AppButtonSize.large,
                            borderRadius: 60.r,
                            height: 56.h,
                            onTap: onClose ?? () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            buttonName: primaryButtonLabel!,
                            variant: AppButtonVariant.secondary,
                            size: AppButtonSize.large,
                            borderRadius: 60.r,
                            height: 56.h,
                            onTap: onPrimaryTap,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      buttonName: closeButtonLabel,
                      variant: AppButtonVariant.outline,
                      size: AppButtonSize.large,
                      borderRadius: 60.r,
                      height: 56.h,
                      onTap: onClose ?? () => Navigator.pop(context),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required AppDrawerPlacement placement,
    required WidgetBuilder builder,
  }) {
    final Alignment alignment = switch (placement) {
      AppDrawerPlacement.top => Alignment.topCenter,
      AppDrawerPlacement.bottom => Alignment.bottomCenter,
      AppDrawerPlacement.left => Alignment.centerLeft,
      AppDrawerPlacement.right => Alignment.centerRight,
    };
    final Offset beginOffset = switch (placement) {
      AppDrawerPlacement.top => const Offset(0, -1),
      AppDrawerPlacement.bottom => const Offset(0, 1),
      AppDrawerPlacement.left => const Offset(-1, 0),
      AppDrawerPlacement.right => const Offset(1, 0),
    };

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: AppColors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (BuildContext context, _, __) {
        return Align(
          alignment: alignment,
          child: Material(color: AppColors.transparent, child: builder(context)),
        );
      },
      transitionBuilder:
          (BuildContext context, Animation<double> animation, _, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }
}
