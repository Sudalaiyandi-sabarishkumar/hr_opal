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

class LoanRequest extends StatefulWidget {
  const LoanRequest({super.key});

  @override
  State<LoanRequest> createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  final TextEditingController _amountController = TextEditingController();

  String? _loanType;
  DateTime? _repaymentStartDate;

  static const List<String> _loanTypes = <String>[
    'Personal Loan',
    'Salary Advance',
    'Housing Loan',
    'Vehicle Loan',
    'Education Loan',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

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

  Future<void> _pickDate({
    required String title,
    required DateTime? current,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showAppDateSheet(
      context,
      title: title,
      initialDate: current,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
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
      title: 'New Loan Request',
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TapRegion(
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: InputFieldGroup(
                        type: InputFieldGroupType.neutral,
                        children: <Widget>[
                          _SelectField(
                            label: 'Loan Type',
                            hint: 'Select',
                            value: _loanType,
                            trailing: SvgPicture.asset(
                              AppAssets.down,
                              width: 8.w,
                              height: 4.h,
                            ),
                            onTap: () => _pickOption(
                              title: 'Select Loan Type',
                              options: _loanTypes,
                              current: _loanType,
                              onSelected: (String v) =>
                                  setState(() => _loanType = v),
                            ),
                          ),
                          AppTextField(
                            label: 'Amount',
                            hint: 'Enter Amount',
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          _SelectField(
                            label: 'Repayment Start',
                            hint: 'Select',
                            value: _repaymentStartDate == null
                                ? null
                                : _formatDate(_repaymentStartDate!),
                            trailing: SvgPicture.asset(
                              AppAssets.calanderIcon,
                              width: 16.w,
                              height: 16.h,
                            ),
                            onTap: () => _pickDate(
                              title: 'Select Repayment Start Date',
                              current: _repaymentStartDate,
                              onSelected: (DateTime d) =>
                                  setState(() => _repaymentStartDate = d),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                            Text(
                              'Upload file',
                              style: textTheme.geist13Regular,
                            ),
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
