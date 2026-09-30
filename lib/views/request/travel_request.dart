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

class TravelRequest extends StatefulWidget {
  const TravelRequest({super.key});

  @override
  State<TravelRequest> createState() => _TravelRequestState();
}

class _TravelRequestState extends State<TravelRequest> {
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _fromPlaceController = TextEditingController();
  final TextEditingController _toPlaceController = TextEditingController();
  final TextEditingController _travelDaysController = TextEditingController();
  final TextEditingController _otherAllowanceController =
      TextEditingController();
  final TextEditingController _hotelAmountController = TextEditingController();
  final TextEditingController _ratePerDayController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _chequeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _step = 0;
  String? _travelType;
  String? _purpose;
  String? _modeOfTravel;
  String? _ticketProvidedBy;
  String? _classOfTravel;
  DateTime? _fromDate;
  DateTime? _toDate;
  bool _accommodationRequired = false;
  bool _fieldAllowanceRequired = false;
  bool _visaRequired = false;

  static const List<String> _travelTypes = <String>[
    'Domestic',
    'International',
  ];
  static const List<String> _purposes = <String>[
    'Client Visit',
    'Training',
    'Conference',
    'Project Work',
    'Other',
  ];
  static const List<String> _modes = <String>['Flight', 'Train', 'Bus', 'Car'];
  static const List<String> _ticketProviders = <String>['Company', 'Self'];
  static const List<String> _classes = <String>[
    'Economy',
    'Premium Economy',
    'Business',
    'Sleeper',
    'AC 3 Tier',
    'AC 2 Tier',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _fromPlaceController.dispose();
    _toPlaceController.dispose();
    _travelDaysController.dispose();
    _otherAllowanceController.dispose();
    _hotelAmountController.dispose();
    _ratePerDayController.dispose();
    _totalAmountController.dispose();
    _chequeController.dispose();
    _descriptionController.dispose();
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

  void _goToStep(int step) {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _step = step);
  }

  void _onSubmit() {
    if (_step != 0) {
      return;
    }
    if (!_isStepOneValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Fill Travel Type, Purpose, From Date and To Date to continue',
          ),
        ),
      );
      return;
    }
    _goToStep(1);
  }

  Widget _dropdown({
    required String label,
    required String title,
    required List<String> options,
    required String? value,
    required ValueChanged<String> onSelected,
    bool isRequired = false,
  }) {
    return _SelectField(
      label: label,
      hint: 'Select',
      value: value,
      isRequired: isRequired,
      trailing: SvgPicture.asset(AppAssets.down, width: 8.w, height: 4.h),
      onTap: () => _pickOption(
        title: title,
        options: options,
        current: value,
        onSelected: onSelected,
      ),
    );
  }

  Widget _dateField({
    required String label,
    required String title,
    required DateTime? value,
    required ValueChanged<DateTime> onSelected,
  }) {
    return _SelectField(
      label: label,
      hint: 'Select',
      value: value == null ? null : _formatDate(value),
      trailing: SvgPicture.asset(
        AppAssets.calanderIcon,
        width: 16.w,
        height: 16.h,
      ),
      onTap: () =>
          _pickDate(title: title, current: value, onSelected: onSelected),
    );
  }

  bool get _isStepOneValid =>
      _travelType != null &&
      _purpose != null &&
      _fromDate != null &&
      _toDate != null;

  Widget _stepHeader() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _step == 0 ? 'Travel Details' : 'Expense Details',
                style: textTheme.geist12Regular.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              'Step ${_step + 1}/2',
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: <Widget>[
            _stepBar(0),
            SizedBox(width: 8.w),
            _stepBar(1),
          ],
        ),
      ],
    );
  }

  Widget _stepBar(int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (index == 0) {
            _goToStep(0);
          } else {
            _onSubmit();
          }
        },
        child: Container(
          height: 3.h,
          decoration: BoxDecoration(
            color: index <= _step
                ? AppColors.secondary500
                : AppColors.neutral200,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }

  Widget _checkboxRow(String label, bool value, ValueChanged<bool> onChanged) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: <Widget>[
            AppCheckbox(
              value: value,
              onChanged: (bool? v) => onChanged(v ?? false),
            ),
            SizedBox(width: 12.w),
            Text(label, style: textTheme.geist14Regular),
          ],
        ),
      ),
    );
  }

  Widget _travelDetails() {
    return InputFieldGroup(
      type: InputFieldGroupType.neutral,
      children: <Widget>[
        _dropdown(
          label: 'Travel Type',
          title: 'Select Travel Type',
          options: _travelTypes,
          value: _travelType,
          isRequired: true,
          onSelected: (String v) => setState(() => _travelType = v),
        ),
        _dropdown(
          label: 'Purpose',
          title: 'Select Purpose',
          options: _purposes,
          value: _purpose,
          isRequired: true,
          onSelected: (String v) => setState(() => _purpose = v),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _dateField(
                label: 'From Date',
                title: 'Select From Date',
                value: _fromDate,
                onSelected: (DateTime d) => setState(() => _fromDate = d),
              ),
            ),
            Expanded(
              child: _dateField(
                label: 'To Date',
                title: 'Select To Date',
                value: _toDate,
                onSelected: (DateTime d) => setState(() => _toDate = d),
              ),
            ),
          ],
        ),
        AppTextField(
          label: 'Client Name',
          hint: 'Enter Client name',
          controller: _clientNameController,
          isRequired: false,
        ),
        _dropdown(
          label: 'Mode of Travel',
          title: 'Select Mode of Travel',
          options: _modes,
          value: _modeOfTravel,
          onSelected: (String v) => setState(() => _modeOfTravel = v),
        ),
        _dropdown(
          label: 'Ticket Provided by',
          title: 'Select Ticket Provider',
          options: _ticketProviders,
          value: _ticketProvidedBy,
          onSelected: (String v) => setState(() => _ticketProvidedBy = v),
        ),
        _dropdown(
          label: 'Class of Travel',
          title: 'Select Class of Travel',
          options: _classes,
          value: _classOfTravel,
          onSelected: (String v) => setState(() => _classOfTravel = v),
        ),
        AppTextField(
          label: 'From Place',
          hint: 'Enter From Place',
          controller: _fromPlaceController,
          isRequired: false,
        ),
        AppTextField(
          label: 'To Place',
          hint: 'Enter To Place',
          controller: _toPlaceController,
          isRequired: false,
        ),
        AppTextField(
          label: 'Travel Days',
          hint: 'Enter Days',
          controller: _travelDaysController,
          isRequired: false,
          numericOnly: true,
        ),
      ],
    );
  }

  Widget _expenseDetails() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    const TextInputType decimal = TextInputType.numberWithOptions(
      decimal: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InputFieldGroup(
          type: InputFieldGroupType.neutral,
          children: <Widget>[
            AppTextField(
              label: 'Other Allowance',
              hint: 'Enter Allowance',
              controller: _otherAllowanceController,
              isRequired: false,
              keyboardType: decimal,
            ),
            _checkboxRow(
              'Accommodation Required',
              _accommodationRequired,
              (bool v) => setState(() => _accommodationRequired = v),
            ),
            AppTextField(
              label: 'Hotel Amount',
              hint: 'Enter Hotel Amount',
              controller: _hotelAmountController,
              keyboardType: decimal,
            ),
            AppTextField(
              label: 'Rate per Day',
              hint: 'Enter Rate per Day',
              controller: _ratePerDayController,
              keyboardType: decimal,
            ),
            _checkboxRow(
              'Field Allowance Required',
              _fieldAllowanceRequired,
              (bool v) => setState(() => _fieldAllowanceRequired = v),
            ),
            AppTextField(
              label: 'Total Amount',
              hint: 'Enter Amount',
              controller: _totalAmountController,
              isRequired: false,
              keyboardType: decimal,
            ),
            AppTextField(
              label: 'Cheque / NEFT',
              hint: 'Enter Cheque',
              controller: _chequeController,
              isRequired: false,
            ),
            _checkboxRow(
              'Visa Required',
              _visaRequired,
              (bool v) => setState(() => _visaRequired = v),
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
        AppTextArea(
          label: 'Description',
          hint: 'Enter Description',
          controller: _descriptionController,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'New Travel Request',
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: Row(children: <Widget>[Expanded(child: _stepHeader())]),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: TapRegion(
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  child: _step == 0 ? _travelDetails() : _expenseDetails(),
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
