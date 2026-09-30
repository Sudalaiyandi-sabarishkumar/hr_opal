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

class EncashmentRequest extends StatefulWidget {
  const EncashmentRequest({super.key});

  @override
  State<EncashmentRequest> createState() => _EncashmentRequestState();
}

class _EncashmentRequestState extends State<EncashmentRequest> {
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _category;
  String? _subCategory;
  String? _payMode;

  static const Map<String, List<String>> _subCategories =
      <String, List<String>>{
        'Leave': <String>['Annual Leave', 'Sick Leave', 'Casual Leave'],
        'Compensation': <String>['Comp Off', 'Overtime'],
        'Benefits': <String>['Travel Allowance', 'Medical Allowance'],
      };
  static const List<String> _payModes = <String>[
    'Payroll',
    'Bank Transfer',
    'Cheque',
  ];

  @override
  void dispose() {
    _daysController.dispose();
    _descriptionController.dispose();
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

  Widget _dropdown({
    required String label,
    required String title,
    required List<String> options,
    required String? value,
    required ValueChanged<String> onSelected,
  }) {
    return _SelectField(
      label: label,
      hint: 'Select',
      value: value,
      trailing: SvgPicture.asset(AppAssets.down, width: 8.w, height: 4.h),
      onTap: () => _pickOption(
        title: title,
        options: options,
        current: value,
        onSelected: onSelected,
      ),
    );
  }

  Widget _scaffold(String title, List<Widget> children) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: title,
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
                    children: children,
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

  void _onSubCategoryTap() {
    if (_category == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select a category first')));
      return;
    }
    _pickOption(
      title: 'Select Sub Category',
      options: _subCategories[_category]!,
      current: _subCategory,
      onSelected: (String v) => setState(() => _subCategory = v),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold('New Encashment Request', <Widget>[
      InputFieldGroup(
        type: InputFieldGroupType.neutral,
        children: <Widget>[
          _dropdown(
            label: 'Category',
            title: 'Select Category',
            options: _subCategories.keys.toList(),
            value: _category,
            onSelected: (String v) => setState(() {
              if (v != _category) {
                _subCategory = null;
              }
              _category = v;
            }),
          ),
          _SelectField(
            label: 'Sub Category',
            hint: 'Select',
            value: _subCategory,
            trailing: SvgPicture.asset(AppAssets.down, width: 8.w, height: 4.h),
            onTap: _onSubCategoryTap,
          ),
          _SelectField(
            label: 'Balance',
            hint: 'Auto Units',
            isRequired: false,
            trailing: const SizedBox.shrink(),
            onTap: () {},
          ),
          AppTextField(
            label: 'Days/Units to encash',
            hint: 'Enter Units',
            controller: _daysController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          _dropdown(
            label: 'Pay Mode',
            title: 'Select Pay Mode',
            options: _payModes,
            value: _payMode,
            onSelected: (String v) => setState(() => _payMode = v),
          ),
        ],
      ),
      SizedBox(height: 20.h),
      AppTextArea(
        label: 'Description',
        hint: 'Enter Description',
        controller: _descriptionController,
      ),
    ]);
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.hint,
    required this.trailing,
    required this.onTap,
    this.value,
    this.isRequired = true,
  });

  final String label;
  final String hint;
  final String? value;
  final Widget trailing;
  final VoidCallback onTap;
  final bool isRequired;

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
                      children: isRequired
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
