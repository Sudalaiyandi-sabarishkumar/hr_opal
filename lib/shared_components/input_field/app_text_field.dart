import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_color.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/theme/app_typography.dart';

/// A single labeled input row — label + red asterisk above, value/hint
/// below. Used inside an [InputFieldGroup], either alone (e.g. Mobile
/// Number) or stacked with other fields sharing one card (e.g. Email ID
/// + Password).
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isRequired = true,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: widget.label,
                    style: textTheme.geist13Regular,
                    children: widget.isRequired
                        ? <InlineSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red.shade400),
                            ),
                          ]
                        : null,
                  ),
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: widget.controller,
                  obscureText: _obscure,
                  keyboardType: widget.keyboardType,
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: textTheme.geist16Regular,
                  ),
                  style: textTheme.geist16Regular,
                ),
              ],
            ),
          ),
          if (widget.isPassword) ...<Widget>[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 15.r,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Rounded card that groups one or more [AppTextField]s, drawing a
/// divider between adjacent fields.
/// - Pass a single field for a standalone card (Mobile Number).
/// - Pass two+ fields for a combined card (Email ID + Password).
class InputFieldGroup extends StatelessWidget {
  const InputFieldGroup({super.key, required this.children});

  final List<Widget> children;

  // border: 0.4px solid, gradient border-image
  static const double _borderWidth = 0.4;

  // border-image-source: linear-gradient(89.85deg, #FFFFFF 0.13%, #BCC7E4 80.55%, #FFFFFF 141.98%)
  // 89.85deg ≈ left-to-right; stops normalized against the 141.98% range.
  static const LinearGradient _borderGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    transform: GradientRotation(89.85 * math.pi / 180),
    colors: <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFBCC7E4),
      Color(0xFFFFFFFF),
    ],
    stops: <double>[0.0009, 0.5673, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final double radius = 14.r;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: _borderGradient,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0x14FFFFFF), // #FFFFFF14
            offset: Offset(0, 3.h),
            blurRadius: 4.8.r,
          ),
        ],
      ),
      padding: EdgeInsets.all(_borderWidth),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius - _borderWidth),
          color: const Color(0x80ECECEC), // #ECECEC80
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < children.length; i++) ...<Widget>[
              children[i],
              if (i != children.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: const Color(0x80ECECEC),
                ),
            ],
          ],
        ),
      ),
    );
  }
}