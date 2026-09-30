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

class TaxRequest extends StatefulWidget {
  const TaxRequest({super.key});

  @override
  State<TaxRequest> createState() => _TaxRequestState();
}

class _TaxItem {
  _TaxItem(this.title, this.maxAmount);

  final String title;
  final int maxAmount;
  final TextEditingController amount = TextEditingController();
  final TextEditingController approvedAmount = TextEditingController();

  void dispose() {
    amount.dispose();
    approvedAmount.dispose();
  }
}

class _TaxRequestState extends State<TaxRequest> {
  final List<_TaxItem> _exemptions = <_TaxItem>[
    _TaxItem('House Rent Allowance', 2000),
    _TaxItem('Leave Travel Allowance', 4500),
  ];
  final List<_TaxItem> _deductions = <_TaxItem>[
    _TaxItem('Home Loan Interest', 2000),
    _TaxItem('Serious Diseases - Normal', 4500),
  ];

  static const List<String> _financialYears = <String>[
    '2023-24',
    '2024-25',
    '2025-26',
  ];
  static const List<String> _regimes = <String>['Old Regime', 'New Regime'];
  static const List<String> _tabs = <String>['Exemption', 'Deduction'];

  String? _financialYear;
  String? _regime;
  int _tabIndex = 0;

  @override
  void dispose() {
    for (final _TaxItem item in <_TaxItem>[..._exemptions, ..._deductions]) {
      item.dispose();
    }
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

  Widget _attachment() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: 'Attachment',
              style: textTheme.geist13Regular.copyWith(
                color: AppColors.toastMessage,
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
          SizedBox(height: 8.h),
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.statusSoftBg,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppAssets.payrollUpload,
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(width: 8.w),
                  Text('Upload file', style: textTheme.geist13Regular),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Center(
            child: Text(
              'Supporting files are png, pdf, jpeg & max size 10MB',
              style: textTheme.geist10Regular.copyWith(
                color: AppColors.neutral300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemCard(_TaxItem item, int index) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isBlue = index.isEven;
    const Widget divider = Divider(
      height: 1,
      thickness: 1,
      color: AppColors.borderSubtle,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: InputFieldGroupScope(
          type: InputFieldGroupType.neutral,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: isBlue ? AppColors.bg2Blue : AppColors.accordionPurpleBg,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: textTheme.geist14Medium.copyWith(
                        color: isBlue
                            ? AppColors.primary700
                            : AppColors.secondary500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Max Amount ${item.maxAmount}',
                      style: textTheme.geist12Regular.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              AppTextField(
                label: 'Amount',
                hint: 'Enter Amount',
                controller: item.amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              divider,
              AppTextField(
                label: 'Approved Amount',
                hint: 'Enter Amount',
                controller: item.approvedAmount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              divider,
              _attachment(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<_TaxItem> items = _tabIndex == 0 ? _exemptions : _deductions;

    return AppGradientHeaderScaffold(
      title: 'New Employee Tax Request',
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
                    children: <Widget>[
                      InputFieldGroup(
                        type: InputFieldGroupType.neutral,
                        children: <Widget>[
                          _dropdown(
                            label: 'Financial Year',
                            title: 'Select Financial Year',
                            options: _financialYears,
                            value: _financialYear,
                            onSelected: (String v) =>
                                setState(() => _financialYear = v),
                          ),
                          _dropdown(
                            label: 'Regime',
                            title: 'Select Regime',
                            options: _regimes,
                            value: _regime,
                            onSelected: (String v) =>
                                setState(() => _regime = v),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      AppSegmentedTabs(
                        labels: _tabs,
                        selectedIndex: _tabIndex,
                        isExpanded: true,
                        onChanged: (int i) => setState(() => _tabIndex = i),
                      ),
                      SizedBox(height: 20.h),
                      for (int i = 0; i < items.length; i++)
                        _itemCard(items[i], i),
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
