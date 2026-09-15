import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class AppRadio<T> extends StatefulWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
    this.forceFocused,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final bool enabled;
  final bool? forceFocused;

  @override
  State<AppRadio<T>> createState() => _AppRadioState<T>();
}

class _AppRadioState<T> extends State<AppRadio<T>> {
  bool _focused = false;

  bool get _interactive => widget.enabled && widget.onChanged != null;

  bool get _isFocused => widget.forceFocused ?? _focused;

  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (!_interactive) {
      return;
    }
    widget.onChanged!(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final double size = 20.r;

    final Color fill = !widget.enabled
        ? (_isSelected ? AppColors.neutral300 : AppColors.neutral100)
        : (_isSelected ? AppColors.statusInfo : AppColors.white);
    final Color border = !widget.enabled
        ? AppColors.neutral300
        : (_isSelected ? AppColors.statusInfo : AppColors.neutral300);

    final Widget circle = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 1.5),
        boxShadow: _isFocused
            ? <BoxShadow>[
                BoxShadow(color: AppColors.focusRing, spreadRadius: 4.r),
                BoxShadow(color: AppColors.white, spreadRadius: 2.r),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: _isSelected
          ? Container(
              width: 6.r,
              height: 6.r,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );

    return Opacity(
      opacity: widget.enabled ? 1 : 0.4,
      child: Focus(
        canRequestFocus: _interactive,
        onFocusChange: (bool hasFocus) => setState(() => _focused = hasFocus),
        child: GestureDetector(onTap: _handleTap, child: circle),
      ),
    );
  }
}
