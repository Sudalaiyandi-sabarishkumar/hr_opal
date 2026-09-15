import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.forceFocused,
  });

  /// `null` renders the indeterminate ("mixed") state.
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;
  final bool? forceFocused;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool _focused = false;

  bool get _interactive => widget.enabled && widget.onChanged != null;

  bool get _isFocused => widget.forceFocused ?? _focused;

  void _handleTap() {
    if (!_interactive) {
      return;
    }
    widget.onChanged!(widget.value != true);
  }

  @override
  Widget build(BuildContext context) {
    final double size = 20.r;
    final bool isChecked = widget.value == true;
    final bool isIndeterminate = widget.value == null;
    final bool isFilled = isChecked || isIndeterminate;

    final Color fill = !widget.enabled
        ? (isFilled ? AppColors.neutral300 : AppColors.neutral100)
        : (isFilled ? AppColors.statusInfo : AppColors.white);
    final Color border = !widget.enabled
        ? AppColors.neutral300
        : (isFilled ? AppColors.statusInfo : AppColors.neutral300);

    final Widget box = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: border, width: 1.5),
        boxShadow: _isFocused
            ? <BoxShadow>[
                BoxShadow(color: AppColors.focusRing, spreadRadius: 4.r),
                BoxShadow(color: AppColors.white, spreadRadius: 2.r),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: isChecked
          ? Icon(Icons.check, size: 14.r, color: AppColors.white)
          : isIndeterminate
          ? Icon(Icons.remove, size: 14.r, color: AppColors.white)
          : null,
    );

    return Opacity(
      opacity: widget.enabled ? 1 : 0.4,
      child: Focus(
        canRequestFocus: _interactive,
        onFocusChange: (bool hasFocus) => setState(() => _focused = hasFocus),
        child: GestureDetector(onTap: _handleTap, child: box),
      ),
    );
  }
}
