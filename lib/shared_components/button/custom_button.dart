import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = true,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.icon,
    this.iconSize,
    this.isReverse = false,
    this.gap,
  });

  final String buttonName;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final String? icon;
  final double? iconSize;
  final bool isReverse;
  final double? gap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _pressed = false;

  bool get _isSolid => switch (widget.variant) {
    AppButtonVariant.primary => true,
    AppButtonVariant.secondary => true,
    AppButtonVariant.dark => true,
    AppButtonVariant.light => false,
    AppButtonVariant.subtle => false,
    AppButtonVariant.outline => false,
    AppButtonVariant.neutral => false,
  };

  Color get _baseColor => switch (widget.variant) {
    AppButtonVariant.primary => AppColors.statusInfo,
    AppButtonVariant.secondary => AppColors.secondary500,
    AppButtonVariant.dark => AppColors.textPrimary,
    AppButtonVariant.light => AppColors.white,
    AppButtonVariant.subtle => AppColors.neutral50,
    AppButtonVariant.outline => AppColors.white,
    AppButtonVariant.neutral => AppColors.statusSoftBg,
  };

  Color get _pressedFillColor => switch (widget.variant) {
    AppButtonVariant.neutral => AppColors.neutral200,
    _ => AppColors.statusSoftBg,
  };

  Color get _textColor => switch (widget.variant) {
    AppButtonVariant.primary => AppColors.white,
    AppButtonVariant.secondary => AppColors.white,
    AppButtonVariant.dark => AppColors.white,
    AppButtonVariant.light => AppColors.textPrimary,
    AppButtonVariant.subtle => AppColors.textPrimary,
    AppButtonVariant.outline => AppColors.textPrimary,
    AppButtonVariant.neutral => AppColors.textPrimary,
  };

  Border? get _border => widget.variant == AppButtonVariant.outline
      ? Border.all(color: AppColors.neutral300)
      : null;

  double get _height => widget.height ?? switch (widget.size) {
    AppButtonSize.large => 48.h,
    AppButtonSize.medium => 40.h,
    AppButtonSize.small => 32.h,
  };

  double get _horizontalPadding => switch (widget.size) {
    AppButtonSize.large => 20.w,
    AppButtonSize.medium => 16.w,
    AppButtonSize.small => 12.w,
  };

  double get _borderRadius => widget.borderRadius ?? switch (widget.size) {
    AppButtonSize.large => 12.r,
    AppButtonSize.medium => 12.r,
    AppButtonSize.small => 12.r,
  };

  double get _iconSize => widget.iconSize ?? switch (widget.size) {
    AppButtonSize.large => 18.r,
    AppButtonSize.medium => 16.r,
    AppButtonSize.small => 14.r,
  };

  TextStyle _labelStyle(TextTheme textTheme) => switch (widget.size) {
    AppButtonSize.large => textTheme.geist16Medium,
    AppButtonSize.medium => textTheme.geist14Medium,
    AppButtonSize.small => textTheme.geist12Medium,
  };

  Decoration get _decoration {
    final BorderRadius radius = BorderRadius.circular(_borderRadius);

    if (_isSolid) {
      final Color base = _pressed
          ? Color.alphaBlend(AppColors.buttonPressedOverlay, _baseColor)
          : _baseColor;

      if (widget.size == AppButtonSize.large) {
        return BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.alphaBlend(AppColors.buttonPressedOverlay, base),
              base,
            ],
          ),
        );
      }
      return BoxDecoration(color: base, borderRadius: radius);
    }

    return BoxDecoration(
      color: _pressed ? _pressedFillColor : _baseColor,
      borderRadius: radius,
      border: _border,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool interactive =
        !widget.isDisabled && !widget.isLoading && widget.onTap != null;

    final Widget content = widget.isLoading
        ? SizedBox(
            height: 16.h,
            width: 16.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(_textColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: widget.gap ?? 8.w,
            children: <Widget>[
              if (widget.icon != null && !widget.isReverse) _buildIcon(),
              Flexible(
                child: Text(
                  widget.buttonName,
                  style:
                      widget.textStyle?.copyWith(color: _textColor) ??
                      _labelStyle(textTheme).copyWith(color: _textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.icon != null && widget.isReverse) _buildIcon(),
            ],
          );

    return Opacity(
      opacity: widget.isDisabled ? 0.4 : 1,
      child: GestureDetector(
        onTapDown: interactive ? (_) => setState(() => _pressed = true) : null,
        onTapCancel: interactive
            ? () => setState(() => _pressed = false)
            : null,
        onTapUp: interactive ? (_) => setState(() => _pressed = false) : null,
        onTap: interactive ? widget.onTap : null,
        child: Container(
          height: _height,
          width: widget.isFullWidth ? double.infinity : null,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          alignment: Alignment.center,
          decoration: _decoration,
          child: content,
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final String path = widget.icon!;
    final double size = _iconSize;
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(path, width: size, height: size);
    }
    return Image.asset(path, width: size, height: size);
  }
}
