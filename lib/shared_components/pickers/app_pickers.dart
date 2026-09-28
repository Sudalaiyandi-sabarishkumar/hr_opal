import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../button/custom_button.dart';
import '../shared_components.dart';

// TODO: swap these for your AppColors equivalents.
const Color _purple = Color(0xFF5B3FA0);
const Color _purpleLight = Color(0xFF6E4BB8);
const Color _border = Color(0xFFE9E9EE);
const Color _grey = Color(0xFF8A8A9A);
const Color _cancelBg = Color(0xFFEAEAEE);
const Color _disabledBg = Color(0xFFF3F3F6);
const Color _disabledText = Color(0xFFC9C9D2);
const Color _textDark = Color(0xFF0F0D14);

Future<T?> _showSheet<T>(BuildContext context, Widget child) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(top: false, child: child),
    ),
  );
}

/// "Select Expense type" style list sheet.
Future<String?> showAppOptionSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
  String? selected,
}) {
  return _showSheet<String>(
    context,
    Builder(
      builder: (BuildContext ctx) {
        final TextTheme t = Theme.of(ctx).textTheme;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.75,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: t.geist20SemiBold.copyWith(
                    fontFamily: hostGroteskFont,
                    color: AppColors.dropdownBlack
                  ),
                ),
                SizedBox(height: 16.h),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (_, int i) {
                      final bool isSel = options[i] == selected;
                      return InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () => Navigator.pop(ctx, options[i]),
                        child: Container(
                          height: 56.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSel ? _purple : _border,
                            ),
                          ),
                          child: Text(
                            options[i],
                            style: t.geist16Regular.copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

/// "Select From Date" style calendar sheet. Returns null on Cancel.
Future<DateTime?> showAppDateSheet(
  BuildContext context, {
  required String title,
  DateTime? initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return _showSheet<DateTime>(
    context,
    _CalendarSheet(
      title: title,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ),
  );
}

class _CalendarSheet extends StatefulWidget {
  const _CalendarSheet({
    required this.title,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
  });

  final String title;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<_CalendarSheet> {
  static const List<String> _months = <String>[
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December',
  ];
  static const List<String> _weekdays = <String>[
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  late DateTime _month; // first day of displayed month
  DateTime? _selected;
  bool _pickingMonth = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    final DateTime base = widget.initialDate ?? DateTime.now();
    _month = DateTime(base.year, base.month);
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _enabled(DateTime d) {
    final DateTime day = DateTime(d.year, d.month, d.day);
    final DateTime f = DateTime(
      widget.firstDate.year, widget.firstDate.month, widget.firstDate.day);
    final DateTime l = DateTime(
      widget.lastDate.year, widget.lastDate.month, widget.lastDate.day);
    return !day.isBefore(f) && !day.isAfter(l);
  }

  void _shift(int delta) {
    setState(() {
      _month = _pickingMonth
          ? DateTime(_month.year + delta, _month.month)
          : DateTime(_month.year, _month.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 24.h, 12.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              widget.title,
              style: t.geist20SemiBold.copyWith(
                fontFamily: hostGroteskFont,
                color: AppColors.dropdownBlack
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _header(t),
          SizedBox(height: 12.h),
          if (_pickingMonth) _monthGrid(t) else ...<Widget>[
            _weekdayRow(t),
            SizedBox(height: 4.h),
            _dayGrid(t),
          ],
          SizedBox(height: 16.h),
          _buttons(t),
        ],
      ),
    );
  }

  Widget _header(TextTheme t) {
    final TextStyle style = t.geist20SemiBold.copyWith(
      color: AppColors.secondary500,
      fontFamily: hostGroteskFont
      
    );
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _pickingMonth = !_pickingMonth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Row(
              children: <Widget>[
                Text(
                  _pickingMonth
                      ? '${_month.year}'
                      : '${_months[_month.month - 1]} ${_month.year}',
                  style: style,
                ),
                SizedBox(width: 6.w),
                Icon(
                  _pickingMonth
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20.r,
                  color: _textDark,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.chevron_left, color: _purple, size: 22.r),
          onPressed: () => _shift(-1),
        ),
        SizedBox(width: 16.w),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.chevron_right, color: _purple, size: 22.r),
          onPressed: () => _shift(1),
        ),
      ],
    );
  }

  Widget _weekdayRow(TextTheme t) {
    return Row(
      children: <Widget>[
        for (final String d in _weekdays)
          Expanded(
            child: Center(
              child: Text(
                d,
                style: t.geist14Regular.copyWith(
                  color: AppColors.neutral300,
                  
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _dayGrid(TextTheme t) {
    final int leading = _month.weekday - 1; // Monday start
    final DateTime start = DateTime(_month.year, _month.month, 1 - leading);

    return Column(
      children: <Widget>[
        for (int r = 0; r < 6; r++)
          Row(
            children: <Widget>[
              for (int c = 0; c < 7; c++)
                Expanded(child: _dayCell(t, DateTime(
                  start.year, start.month, start.day + r * 7 + c))),
            ],
          ),
      ],
    );
  }

  Widget _dayCell(TextTheme t, DateTime d) {
    final bool inMonth = d.month == _month.month;
    final bool isSel = _selected != null && _sameDay(d, _selected!);
    final bool ok = _enabled(d);

    Color color = inMonth ? AppColors.textPrimary : AppColors.toastMessage;
    if (!ok) color = _disabledText;
    if (isSel) color = Colors.white;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: !ok
          ? null
          : () => setState(() {
                _selected = d;
                _month = DateTime(d.year, d.month);
              }),
      child: SizedBox(
        height: 40.h,
        child: Center(
          child: Container(
            width: 30.r,
            height: 30.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSel ? AppColors.darkPurple : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${d.day}',
              style: t.geist13Regular.copyWith(color: color,fontSize: 15.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthGrid(TextTheme t) {
    return SizedBox(
      height: 6 * 40.h + 4.h + 20.h,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          for (int m = 1; m <= 12; m++)
            GestureDetector(
              onTap: () => setState(() {
                _month = DateTime(_month.year, m);
                _pickingMonth = false;
              }),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: m == _month.month ? AppColors.darkPurple : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    _months[m - 1].substring(0, 3),
                    style: t.geist13Regular.copyWith(
                      fontSize: 15.sp,
                      color: m == _month.month ? Colors.white :AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buttons(TextTheme t) {
    final bool canConfirm = _selected != null;
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButton(buttonName: 'Cancel',
          onTap: (){Navigator.pop(context);},
          variant: AppButtonVariant.neutral,
          height: 46.h,
          borderRadius: 60.r,
          textStyle: t.geist14Regular.copyWith(color: AppColors.textPrimary),
          )
        ),
        SizedBox(width: 12.w),
        Expanded(

           child: canConfirm ? CustomButton(buttonName: 'Confirm',
           onTap:(){ Navigator.pop(context, _selected);},
           variant:  AppButtonVariant.secondary ,
           height: 46.h,
          borderRadius: 60.r,
          textStyle: t.geist14Regular.copyWith(color:AppColors.white ),
           ) : CustomButton(buttonName: 'Confirm',
           variant: AppButtonVariant.subtle,
           height: 46.h,
          borderRadius: 60.r,
          textStyle: t.geist14Regular.copyWith(color: AppColors.disabledText),
          textColor: AppColors.disabledText,
           )
        ),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.textColor,
    required this.onTap,
    this.background,
    this.gradient,
  });

  final String label;
  final Color textColor;
  final Color? background;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          gradient: gradient,
          borderRadius: BorderRadius.circular(60.r),
        ),
        child: Text(
          label,
          style: t.geist14Regular.copyWith(color: textColor),
        ),
      ),
    );
  }
}