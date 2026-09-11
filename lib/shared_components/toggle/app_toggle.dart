import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class AppToggle extends StatefulWidget {
  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.forceFocused,
    this.forcePressed,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final bool? forceFocused;
  final bool? forcePressed;

  @override
  State<AppToggle> createState() => _AppToggleState();
}

class _AppToggleState extends State<AppToggle> {
  bool _pressed = false;
  bool _focused = false;

  bool get _interactive => widget.enabled && widget.onChanged != null;

  bool get _isFocused => widget.forceFocused ?? _focused;
  bool get _isPressed => widget.forcePressed ?? _pressed;

  void _handleTap() {
    if (!_interactive) {
      return;
    }
    widget.onChanged!(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final double width = 44.w;
    final double height = 24.h;
    final double knob = height - 4.r;

    final Color track = !widget.enabled
        ? (widget.value ? AppColors.neutral300 : AppColors.neutral200)
        : widget.value
        ? (_isPressed ? AppColors.primary700 : AppColors.statusInfo)
        : AppColors.neutral200;

    final Widget trackWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: height,
      padding: EdgeInsets.all(2.r),
      alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: track,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: _isFocused
            ? <BoxShadow>[
                BoxShadow(color: AppColors.focusRing, spreadRadius: 4.r),
                BoxShadow(color: AppColors.white, spreadRadius: 2.r),
              ]
            : null,
      ),
      child: Container(
        width: knob,
        height: knob,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
      ),
    );

    return Opacity(
      opacity: widget.enabled ? 1 : 0.4,
      child: Focus(
        canRequestFocus: _interactive,
        onFocusChange: (bool hasFocus) => setState(() => _focused = hasFocus),
        child: GestureDetector(
          onTapDown: _interactive
              ? (_) => setState(() => _pressed = true)
              : null,
          onTapCancel: _interactive
              ? () => setState(() => _pressed = false)
              : null,
          onTapUp: _interactive ? (_) => setState(() => _pressed = false) : null,
          onTap: _handleTap,
          child: trackWidget,
        ),
      ),
    );
  }
}
