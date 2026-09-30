import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/input_field/app_text_field.dart';
import '../../shared_components/pickers/app_pickers.dart';
import '../../shared_components/shared_components.dart';

class LetterRequest extends StatefulWidget {
  const LetterRequest({super.key});

  @override
  State<LetterRequest> createState() => _LetterRequestState();
}

class _LetterRequestState extends State<LetterRequest> {
  final TextEditingController _reasonController = TextEditingController();

  String? _letterType;

  static const List<String> _letterTypes = <String>[
    'Salary Certificate',
    'Land',
    'Gold',
    'Bond',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String? current,
    required ValueChanged<String> onSelected,
  }) async {
    final String? picked = await showAppOptionSheet(
      context,
      title: title,
      options: options,
      selected: current,
    );
    if (picked != null) {
      onSelected(picked);
    }
  }

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'New Letter Request',
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: TapRegion(
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InputFieldGroup(
                        type: InputFieldGroupType.neutral,
                        children: <Widget>[
                          _SelectField(
                            label: 'Letter Type',
                            hint: 'Select',
                            value: _letterType,
                            trailing: SvgPicture.asset(
                              AppAssets.down,
                              width: 8.w,
                              height: 4.h,
                            ),
                            onTap: () => _pickOption(
                              title: 'Select Letter Type',
                              options: _letterTypes,
                              current: _letterType,
                              onSelected: (String v) =>
                                  setState(() => _letterType = v),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      AppTextArea(
                        label: 'Reason',
                        hint: 'Enter Reason',
                        controller: _reasonController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      borderRadius: 60.r,
                      textStyle: textTheme.geist14Regular,
                      height: 46.h,
                      buttonName: 'Cancel',
                      variant: AppButtonVariant.neutral,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      textStyle: textTheme.geist14Regular,
                      height: 46.h,
                      borderRadius: 60.r,
                      buttonName: 'Submit',
                      variant: AppButtonVariant.secondary,
                      onTap: _onSubmit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.hint,
    required this.trailing,
    required this.onTap,
    this.value,
  });

  final String label;
  final String hint;
  final String? value;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final InputFieldGroupType groupType = InputFieldGroupScope.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
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
                      text: label,
                      style: textTheme.geist13Regular.copyWith(
                        color: groupType.labelColor,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' *',
                          style: textTheme.geist13Regular.copyWith(
                            color: AppColors.statusDanger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value ?? hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: value == null
                        ? textTheme.geist16Regular.copyWith(
                            color: groupType.hintColor,
                          )
                        : textTheme.geist16Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}
