import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

enum AppToastStatus { message, success, warning, danger }

enum AppToastSurface { dark, light }

class AppToast extends StatelessWidget {
  const AppToast({
    super.key,
    required this.title,
    required this.description,
    this.status = AppToastStatus.message,
    this.surface = AppToastSurface.light,
    this.actionLabel,
    this.onActionTap,
    this.onClose,
    this.textDirection,
  });

  final String title;
  final String description;
  final AppToastStatus status;
  final AppToastSurface surface;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final VoidCallback? onClose;
  final TextDirection? textDirection;

  String get _iconAsset => switch (status) {
    AppToastStatus.message => AppAssets.infoCircle,
    AppToastStatus.success => AppAssets.successCircle,
    AppToastStatus.warning => AppAssets.warningTriangle,
    AppToastStatus.danger => AppAssets.dangerCircle,
  };

  String get _closeAsset => switch (surface) {
    AppToastSurface.light => AppAssets.closeButton,
    AppToastSurface.dark => AppAssets.closeButtonDark,
  };

  Color get _titleColor => switch (surface) {
    AppToastSurface.light => switch (status) {
      AppToastStatus.message => AppColors.toastMessage,
      AppToastStatus.success => AppColors.toastSuccess,
      AppToastStatus.warning => AppColors.toastWarning,
      AppToastStatus.danger => AppColors.toastDanger,
    },
    AppToastSurface.dark => switch (status) {
      AppToastStatus.message => AppColors.white,
      AppToastStatus.success => AppColors.statusSuccess,
      AppToastStatus.warning => AppColors.statusWarning,
      AppToastStatus.danger => AppColors.toastDanger,
    },
  };

  Color get _descriptionColor => surface == AppToastSurface.dark
      ? AppColors.toastDescriptionOnDark
      : AppColors.textSecondary;

  Color _blend(Color glow, double alpha) =>
      Color.alphaBlend(glow.withValues(alpha: alpha), AppColors.white);

  Decoration get _cardDecoration {
    final BorderRadius radius = BorderRadius.circular(16.r);
    if (surface == AppToastSurface.dark) {
      return BoxDecoration(
        color: AppColors.toastDarkSurface,
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      );
    }

    final Border border = Border.all(color: AppColors.white);
    final List<BoxShadow> shadow = <BoxShadow>[
      BoxShadow(
        color: AppColors.toastLightShadow,
        blurRadius: 6.r,
        spreadRadius: 1.r,
      ),
    ];

    if (status == AppToastStatus.message) {
      return BoxDecoration(
        color: AppColors.toastLightBg,
        borderRadius: radius,
        border: border,
        boxShadow: shadow,
      );
    }

    final Color glow = switch (status) {
      AppToastStatus.success => AppColors.toastSuccessGlow,
      AppToastStatus.warning => AppColors.toastWarning,
      AppToastStatus.danger => AppColors.toastDanger,
      AppToastStatus.message => AppColors.toastSuccessGlow,
    };
    final double farAlpha = status == AppToastStatus.danger ? 0.04 : 0.0;

    return BoxDecoration(
      borderRadius: radius,
      border: border,
      boxShadow: shadow,
      gradient: RadialGradient(
        center: Alignment.bottomCenter,
        radius: 3.3,
        transform: const _EllipticalGradientTransform(0.24),
        colors: <Color>[_blend(glow, 0.2), _blend(glow, farAlpha)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget card = Container(
      width: 446.w,
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: _cardDecoration,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(_iconAsset, width: 14.r, height: 14.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.geist14SemiBold.copyWith(
                    color: _titleColor,
                  ),
                ),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.geist12Regular.copyWith(
                    color: _descriptionColor,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null) ...<Widget>[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onActionTap,
              child: Container(
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: surface== AppToastSurface.light ? AppColors.white : _titleColor,
                  borderRadius: BorderRadius.circular(24.r),
                  border: surface == AppToastSurface.light
                      ? Border.all(color: AppColors.neutral200)
                      : null,
                ),
                child: Text(
                  actionLabel!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.geist14Medium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onClose,
            child: SvgPicture.asset(_closeAsset, width: 18.r, height: 18.r),
          ),
        ],
      ),
    );

    if (textDirection == null) {
      return card;
    }
    return Directionality(textDirection: textDirection!, child: card);
  }
}

class _EllipticalGradientTransform extends GradientTransform {
  const _EllipticalGradientTransform(this.scaleY);

  final double scaleY;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double centerY = bounds.center.dy;
    return Matrix4.identity()
      ..translate(0.0, centerY)
      ..scale(1.0, scaleY)
      ..translate(0.0, -centerY);
  }
}
