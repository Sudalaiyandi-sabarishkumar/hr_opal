import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../button/custom_button.dart';

class AppDrawers extends StatelessWidget {
  const AppDrawers({
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

  bool get _isHorizontalEdge =>
      placement == AppDrawerPlacement.top ||
      placement == AppDrawerPlacement.bottom;

  BorderRadius _radius(double r) => switch (placement) {
    AppDrawerPlacement.top => BorderRadius.vertical(bottom: Radius.circular(r)),
    AppDrawerPlacement.bottom => BorderRadius.vertical(top: Radius.circular(r)),
    AppDrawerPlacement.left => BorderRadius.horizontal(right: Radius.circular(r)),
    AppDrawerPlacement.right => BorderRadius.horizontal(left: Radius.circular(r)),
  };

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool handle = showHandle ?? placement == AppDrawerPlacement.bottom;

    return Container(
      width: _isHorizontalEdge ? double.infinity : (width ?? 320.w),
      height: _isHorizontalEdge ? null : height,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: _radius(24.r),
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
      child: Column(
        mainAxisSize: _isHorizontalEdge ? MainAxisSize.min : MainAxisSize.max,
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
             SvgPicture.asset(icon ?? '', width: 32.r, height: 29.r),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

            
              Expanded(
                child: Text(
                  title,
                  style: textTheme.geist18SemiBold.copyWith(
                    color: AppColors.textPrimary,
                    fontFamily: hostGroteskFont
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
          CustomButton(
            buttonName:'Close',
            variant: AppButtonVariant.outline,
            size: AppButtonSize.large,
            borderRadius: 60.r,
            height: 56.h,
            onTap: (){Navigator.pop(context);},
          ),
        ],
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
