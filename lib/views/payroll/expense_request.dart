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

class ExpenseRequest extends StatefulWidget {
  const ExpenseRequest({super.key});

  @override
  State<ExpenseRequest> createState() => _ExpenseRequestState();
}

class _ExpenseRequestState extends State<ExpenseRequest> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _expenseIncurredController =
      TextEditingController();
  final TextEditingController _payFromCompanyController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String? _expenseType;
  String? _currency;
  DateTime? _fromDate;
  DateTime? _toDate;

  static const List<String> _expenseTypes = <String>[
  'Food',
  'Travel',
  'Accommodation',
  'Client Relation',
  'Tickets and Passes',
  'Miscellaneous',
];
  static const List<String> _currencies = <String>['INR', 'USD', 'EUR', 'AED'];

  @override
  void dispose() {
    _referenceController.dispose();
    _expenseIncurredController.dispose();
    _payFromCompanyController.dispose();
    _remarksController.dispose();
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
  if (picked != null) onSelected(picked);
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
  if (picked != null) onSelected(picked);
}

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'New Expense Request',
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputFieldGroup(
              type: InputFieldGroupType.neutral,
              children: <Widget>[
                _SelectField(
                  label: 'Expense Type',
                  hint: 'Select',
                  value: _expenseType,
                  trailing: SvgPicture.asset(
                    AppAssets.down,
                    width: 8.w,
                    height: 4.h,
                  ),
                 onTap: () => _pickOption(
  title: 'Select Expense type',
  options: _expenseTypes,
  current: _expenseType,
  onSelected: (String v) => setState(() => _expenseType = v),
),
                ),
                AppTextField(
                  label: 'Reference Number',
                  hint: 'Enter Reference Number',
                  controller: _referenceController,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _SelectField(
                        label: 'From Date',
                        hint: 'Select',
                        value: _fromDate == null
                            ? null
                            : _formatDate(_fromDate!),
                        trailing: SvgPicture.asset(
                          AppAssets.calanderIcon,
                          width: 16.w,
                          height: 16.h,
                        ),
                        onTap: () => _pickDate(
  title: 'Select From Date',
  current: _fromDate,
  onSelected: (DateTime d) => setState(() => _fromDate = d),
),
                      ),
                    ),
                    Expanded(
                      child: _SelectField(
                        label: 'To Date',
                        hint: 'Select',
                        value: _toDate == null ? null : _formatDate(_toDate!),
                        trailing: SvgPicture.asset(
                          AppAssets.calanderIcon,
                          width: 16.w,
                          height: 16.h,
                        ),
                        onTap: () => _pickDate(
  title: 'Select To Date',
  current: _toDate,
  onSelected: (DateTime d) => setState(() => _toDate = d),
),
                      ),
                    ),
                  ],
                ),
                AppTextField(
                  label: 'Expense Incurred',
                  hint: 'Enter Expense Incurred',
                  controller: _expenseIncurredController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                AppTextField(
                  label: 'Pay From Company',
                  hint: 'Enter Pay from Company',
                  controller: _payFromCompanyController,
                ),
                _SelectField(
                  label: 'Expense Currency',
                  hint: 'Select',
                  value: _currency,
                  trailing: SvgPicture.asset(
                    AppAssets.down,
                    width: 8.w,
                    height: 4.h,
                  ),
                  onTap: () => _pickOption(
  title: 'Select Currency',
  options: _currencies,
  current: _currency,
  onSelected: (String v) => setState(() => _currency = v),
),

                ),
                AppTextField(
                  label: 'Remarks',
                  hint: 'Enter Remarks',
                  controller: _remarksController,
                ),
              ],
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
            SizedBox(height: 20.h),
            Row(
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
