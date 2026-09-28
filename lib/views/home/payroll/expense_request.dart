import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/enums.dart';
import '../../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../../shared_components/input_field/app_text_field.dart';
import '../../../shared_components/shared_components.dart';

// Adjust this path to wherever AppTextField / InputFieldGroup live.

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

  // TODO: replace with real data from your API / enums.
  static const List<String> _expenseTypes = <String>[
    'Travel',
    'Food',
    'Accommodation',
    'Other',
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
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) async {
    final String? picked = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            for (final String o in options)
              ListTile(title: Text(o), onTap: () => Navigator.pop(ctx, o)),
          ],
        ),
      ),
    );
    if (picked != null) onSelected(picked);
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) onSelected(picked);
  }

  void _onSubmit() {
    // TODO: validate + submit.
  }

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
                    options: _expenseTypes,
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
                          current: _fromDate,
                          onSelected: (DateTime d) =>
                              setState(() => _fromDate = d),
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
                          current: _toDate,
                          onSelected: (DateTime d) =>
                              setState(() => _toDate = d),
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
                    options: _currencies,
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
              onTap: () {
                // TODO: open file picker (png, pdf, jpeg, max 10MB).
              },
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
                    SvgPicture.asset(AppAssets.payrollUpload,height: 16.h,width: 16.w,),
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
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () => Navigator.of(context).maybePop(),
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0,
                //       backgroundColor: Colors.grey.shade200,
                //       foregroundColor: Colors.black,
                //       minimumSize: Size.fromHeight(48.h),
                //       shape: const StadiumBorder(),
                //     ),
                //     child: const Text('Cancel'),
                //   ),
                // ),
                // SizedBox(width: 12.w),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: _onSubmit,
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0,
                //       // TODO: use your app's primary purple from AppColors.
                //       backgroundColor: Theme.of(context).colorScheme.primary,
                //       foregroundColor: Colors.white,
                //       minimumSize: Size.fromHeight(48.h),
                //       shape: const StadiumBorder(),
                //     ),
                //     child: const Text('Submit'),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tappable field (dropdown / date) styled like [AppTextField].
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
                        // If AppColors.textPrimary doesn't exist, use your
                        // dark text color here.
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
