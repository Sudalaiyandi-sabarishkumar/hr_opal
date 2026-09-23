import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../gradient_border_box.dart';


class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isRequired = true,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _focusNode.requestFocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: TextStyle(color: AppColors.statusDanger),
                              ),
                            ]
                          : null,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    onTap: () => _focusNode.requestFocus(),
                    obscureText: _obscure,
                    keyboardType: widget.keyboardType,
                    validator: widget.validator,
                    autovalidateMode: widget.autovalidateMode,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hint,
                      hintStyle: textTheme.geist16Regular,
                      errorStyle: textTheme.geist12Regular.copyWith(
                        color: AppColors.statusDanger,
                      ),
                    ),
                    style: textTheme.geist16Regular,
                  ),
                ],
              ),
            ),
            if (widget.isPassword) ...<Widget>[
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 15.r,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Groups one or more [AppTextField]s inside a single gradient-bordered
/// card, matching the shared design spec (see [GradientBorderBox]).
class InputFieldGroup extends StatelessWidget {
  const InputFieldGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GradientBorderBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.textFieldCardBackground,
              ),
          ],
        ],
      ),
    );
  }
}