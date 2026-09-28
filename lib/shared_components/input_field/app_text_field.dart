import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
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
    this.numericOnly = false,
    this.maxLength,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  /// When true, restricts input to digits 0-9 only (e.g. OTP, phone number,
  /// PIN fields). Also switches the on-screen keyboard to numeric unless
  /// [keyboardType] is explicitly overridden.
  final bool numericOnly;

  /// Caps the number of characters that can be entered. The default
  /// character counter is hidden since the design doesn't show one.
  final int? maxLength;

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
    final InputFieldGroupType groupType = InputFieldGroupScope.of(context);

    final List<TextInputFormatter> inputFormatters = <TextInputFormatter>[
      if (widget.numericOnly) FilteringTextInputFormatter.digitsOnly,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(widget.maxLength),
    ];

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
                      style: textTheme.geist13Regular.copyWith(
                        color: groupType.labelColor,
                      ),
                      children: widget.isRequired
                          ? <InlineSpan>[
                              TextSpan(
                                text: ' *',
                                style: textTheme.geist13Regular.copyWith(
                                  color: AppColors.statusDanger,
                                ),
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
                    keyboardType: widget.numericOnly
                        ? (widget.keyboardType ?? TextInputType.number)
                        : widget.keyboardType,
                    inputFormatters:
                        inputFormatters.isEmpty ? null : inputFormatters,
                    maxLength: widget.maxLength,
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
                      // Hide the default "n/max" counter row under the
                      // field; the design has no room/spec for it.
                      counterText: '',
                      hintText: widget.hint,
                      hintStyle: textTheme.geist16Regular.copyWith(
                        color: groupType.hintColor,
                      ),
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

/// Visual variants for [InputFieldGroup].


extension InputFieldGroupTypeStyle on InputFieldGroupType {
  /// null = keep the default text style from the theme.
  Color? get labelColor =>
      this == InputFieldGroupType.neutral ? const Color(0xFF606E82) : null;

  Color? get hintColor =>
      this == InputFieldGroupType.neutral ? const Color(0xFF8896A7) : null;
}

/// Lets fields inside an [InputFieldGroup] know which type they are in.
class InputFieldGroupScope extends InheritedWidget {
  const InputFieldGroupScope({
    super.key,
    required this.type,
    required super.child,
  });

  final InputFieldGroupType type;

  static InputFieldGroupType of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<InputFieldGroupScope>()
          ?.type ??
      InputFieldGroupType.gradient;

  @override
  bool updateShouldNotify(InputFieldGroupScope oldWidget) =>
      type != oldWidget.type;
}

/// Groups one or more fields inside a single card. The look is chosen with
/// [type]; fields inside pick up matching label/hint colors automatically.
class InputFieldGroup extends StatelessWidget {
  const InputFieldGroup({
    super.key,
    required this.children,
    this.type = InputFieldGroupType.gradient,
  });

  final List<Widget> children;
  final InputFieldGroupType type;

  static const Color _neutralBackground = Color(0xFFFAFAFA); // HROPAL Neutral-25
  static const Color _neutralBorder = Color(0xFFEAECF0);

  @override
  Widget build(BuildContext context) {
    final Widget card;
    switch (type) {
      case InputFieldGroupType.gradient:
        card = GradientBorderBox(
          child: _buildRows(AppColors.textFieldCardBackground),
        );
      case InputFieldGroupType.neutral:
        card = Container(
          decoration: BoxDecoration(
            color: _neutralBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _neutralBorder, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: _buildRows(_neutralBorder),
          ),
        );
    }
    return InputFieldGroupScope(type: type, child: card);
  }

  Widget _buildRows(Color dividerColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < children.length; i++) ...<Widget>[
          children[i],
          if (i != children.length - 1)
            Divider(height: 1, thickness: 1, color: dividerColor),
        ],
      ],
    );
  }
}