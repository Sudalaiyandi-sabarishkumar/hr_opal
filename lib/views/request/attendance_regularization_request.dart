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

class AttendanceRegularizationRequest extends StatefulWidget {
  const AttendanceRegularizationRequest({super.key});

  @override
  State<AttendanceRegularizationRequest> createState() =>
      _AttendanceRegularizationRequestState();
}

class _DayEntry {
  TimeOfDay? checkIn;
  TimeOfDay? checkOut;
  final TextEditingController comment = TextEditingController();
}

class _AttendanceRegularizationRequestState
    extends State<AttendanceRegularizationRequest> {
  static const List<String> _months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static const String _shiftTime = '09:30 AM - 05:30 PM';

  final Map<DateTime, _DayEntry> _entries = <DateTime, _DayEntry>{};

  DateTime? _startDate;
  DateTime? _endDate;
  int _dayIndex = 0;

  @override
  void dispose() {
    for (final _DayEntry entry in _entries.values) {
      entry.comment.dispose();
    }
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_months[d.month - 1]} ${d.year}';

  List<DateTime> get _days {
    if (_startDate == null || _endDate == null) {
      return <DateTime>[];
    }
    final List<DateTime> days = <DateTime>[];
    DateTime day = _startDate!;
    while (!day.isAfter(_endDate!)) {
      days.add(day);
      day = DateTime(day.year, day.month, day.day + 1);
    }
    return days;
  }

  _DayEntry _entryFor(DateTime day) => _entries.putIfAbsent(day, _DayEntry.new);

  Future<DateTime?> _selectDate(
    String title,
    DateTime? current,
    DateTime first,
  ) {
    return showAppDateSheet(
      context,
      title: title,
      initialDate: current,
      firstDate: first,
      lastDate: DateTime(DateTime.now().year + 5),
    );
  }

  Future<void> _pickStartDate() async {
    final DateTime? picked = await _selectDate(
      'Select Start Date',
      _startDate,
      DateTime(DateTime.now().year - 5),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      _startDate = picked;
      if (_endDate != null && _endDate!.isBefore(picked)) {
        _endDate = null;
      }
      _dayIndex = 0;
    });
  }

  Future<void> _pickEndDate() async {
    final DateTime? picked = await _selectDate(
      'Select End Date',
      _endDate,
      _startDate ?? DateTime(DateTime.now().year - 5),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      _endDate = picked;
      _dayIndex = 0;
    });
  }

  Future<void> _pickTime(
    String title,
    TimeOfDay? current,
    ValueChanged<TimeOfDay> set,
  ) async {
    final TimeOfDay? picked = await showAppTimeSheet(
      context,
      title: title,
      initialTime: current,
    );
    if (picked != null) {
      set(picked);
    }
  }

  void _onSubmit() {}

  Widget _dateBox() {
    return InputFieldGroup(
      type: InputFieldGroupType.neutral,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _SelectField(
                  label: 'Start Date',
                  hint: 'Select',
                  value: _startDate == null ? null : _formatDate(_startDate!),
                  trailing: SvgPicture.asset(
                    AppAssets.calanderIcon,
                    width: 16.w,
                    height: 16.h,
                  ),
                  onTap: _pickStartDate,
                ),
              ),
              const VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.borderSubtle,
              ),
              Expanded(
                child: _SelectField(
                  label: 'End Date',
                  hint: 'Select',
                  value: _endDate == null ? null : _formatDate(_endDate!),
                  trailing: SvgPicture.asset(
                    AppAssets.calanderIcon,
                    width: 16.w,
                    height: 16.h,
                  ),
                  onTap: _pickEndDate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dayNavigator(List<DateTime> days) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool hasPrev = _dayIndex > 0;
    final bool hasNext = _dayIndex < days.length - 1;

    Widget arrow(String asset, bool enabled, int delta) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? () => setState(() => _dayIndex += delta) : null,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Opacity(
            opacity: enabled ? 1 : 0.3,
            child: SvgPicture.asset(asset, width: 16.w, height: 16.h),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        arrow(AppAssets.chevronLeftIcon, hasPrev, -1),
        SizedBox(width: 24.w),
        Text(
          _formatDate(days[_dayIndex]),
          style: textTheme.geist14Medium.copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(width: 24.w),
        arrow(AppAssets.chevronRightIcon, hasNext, 1),
      ],
    );
  }

  Widget _timeField(String label, TimeOfDay? value, VoidCallback onTap) {
    return _SelectField(
      label: label,
      hint: 'Select',
      value: value?.format(context),
      trailing: SvgPicture.asset(
        AppAssets.requestTime,
        width: 16.w,
        height: 16.h,
      ),
      onTap: onTap,
    );
  }

  Widget _dayCard(DateTime day) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final _DayEntry entry = _entryFor(day);

    return Container(
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
                color: AppColors.accordionGreenBg,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Shift Time',
                            style: textTheme.geist10Regular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _shiftTime,
                            style: textTheme.geist12Regular.copyWith(
                              color: AppColors.accordionGreenFg,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 5.r,
                            height: 5.r,
                            decoration: const BoxDecoration(
                              color: AppColors.accordionGreenFg,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Present',
                            style: textTheme.geist10Regular.copyWith(
                              color: AppColors.accordionGreenFg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _timeField(
                        'Check In Time',
                        entry.checkIn,
                        () => _pickTime(
                          'Select Check In Time',
                          entry.checkIn,
                          (TimeOfDay t) => setState(() => entry.checkIn = t),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: AppColors.borderSubtle,
                    ),
                    Expanded(
                      child: _timeField(
                        'Check Out Time',
                        entry.checkOut,
                        () => _pickTime(
                          'Select Check Out Time',
                          entry.checkOut,
                          (TimeOfDay t) => setState(() => entry.checkOut = t),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.borderSubtle,
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: AppTextArea(
                  label: 'Comments',
                  hint: 'Enter Comment',
                  controller: entry.comment,
                  isRequired: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<DateTime> days = _days;

    return AppGradientHeaderScaffold(
      title: 'New Attendance Regularization',
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
                      _dateBox(),
                      if (days.isNotEmpty) ...<Widget>[
                        SizedBox(height: 16.h),
                        _dayNavigator(days),
                        SizedBox(height: 16.h),
                        _dayCard(days[_dayIndex]),
                      ],
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
