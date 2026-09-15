import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../button/custom_button.dart';

class AppModal extends StatelessWidget {
  const AppModal({
    super.key,
    required this.title,
    required this.description,
    required this.cancelLabel,
    required this.confirmLabel,
    required this.onConfirm,
    this.leadingIcon = Icons.add,
    this.onLeadingTap,
    this.onClose,
    this.onCancel,
  });

  final String title;
  final String description;
  final String cancelLabel;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final IconData leadingIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onClose;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 400.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
          BoxShadow(
            color: AppColors.modalShadowSoft,
            blurRadius: 12.r,
            offset: Offset(0, -6.h),
          ),
          BoxShadow(
            color: AppColors.modalShadowAmbient,
            blurRadius: 28.r,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _circleIconButton(
                icon: leadingIcon,
                background: AppColors.statusInfoSoft,
                iconColor: AppColors.statusInfo,
                size: 40.r,
                onTap: onLeadingTap,
              ),
              const Spacer(),
              _circleIconButton(
                icon: Icons.close,
                background: AppColors.primary25,
                iconColor: AppColors.textPrimary,
                size: 28.r,
                onTap: onClose,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            style: textTheme.geist18SemiBold.copyWith(
              color: AppColors.textPrimary,
              fontFamily: hostGroteskFont,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: textTheme.geist14Regular.copyWith(
              color: AppColors.statusNeutralText,
              
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CustomButton(
                buttonName: cancelLabel,
                variant: AppButtonVariant.neutral,
                size: AppButtonSize.small,
                isFullWidth: false,
                textStyle: textTheme.geist12Medium,
                onTap: onCancel,
              ),
              SizedBox(width: 10.w),
              CustomButton(
                buttonName: confirmLabel,
                size: AppButtonSize.small,
                isFullWidth: false,
                textStyle: textTheme.geist12Medium,
                onTap: onConfirm,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String description,
    required String cancelLabel,
    required String confirmLabel,
    required VoidCallback onConfirm,
    IconData leadingIcon = Icons.add,
    VoidCallback? onLeadingTap,
    VoidCallback? onCancel,
    VoidCallback? onClose,
    TextDirection? textDirection,
  }) {
    final TextDirection dialogDirection =
        textDirection ?? Directionality.of(context);
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: AppColors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (BuildContext context, _, __) {
        return Directionality(
          textDirection: dialogDirection,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Material(
                color: AppColors.transparent,
                child: AppModal(
                  title: title,
                  description: description,
                  cancelLabel: cancelLabel,
                  confirmLabel: confirmLabel,
                  onConfirm: onConfirm,
                  leadingIcon: leadingIcon,
                  onLeadingTap: onLeadingTap,
                  onCancel: onCancel,
                  onClose: onClose,
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder:
          (BuildContext context, Animation<double> animation, _, Widget child) {
        final CurvedAnimation curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: curved, child: child),
        );
      },
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required Color background,
    required Color iconColor,
    required double size,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: size * 0.6, color: iconColor),
      ),
    );
  }
}
