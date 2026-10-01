import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';
import '../profile/family_address_details.dart';

class _LeaveBalance {
  const _LeaveBalance({
    required this.name,
    required this.left,
    required this.used,
    required this.bg,
    required this.fg,
  });

  final String name;
  final int left;
  final int used;
  final Color bg;
  final Color fg;
}

class _LeaveRecord {
  const _LeaveRecord({
    required this.id,
    required this.title,
    required this.approver,
    required this.dateLabel,
    required this.date,
  });

  final String id;
  final String title;
  final String approver;
  final String dateLabel;
  final String date;
}

class MyLeavesPage extends StatelessWidget {
  const MyLeavesPage({super.key});

  static const List<_LeaveBalance> _balances = <_LeaveBalance>[
    _LeaveBalance(
      name: 'General Leave',
      left: 6,
      used: 2,
      bg: AppColors.calanderBgPurple,
      fg: AppColors.appBarTitleColor,
    ),
    _LeaveBalance(
      name: 'Sick Leave',
      left: 4,
      used: 4,
      bg: AppColors.sickLeaveBg,
      fg: AppColors.statusWarningText,
    ),
    _LeaveBalance(
      name: 'Casual Leave',
      left: 6,
      used: 2,
      bg: AppColors.leaveCasualBg,
      fg: AppColors.leaveCasualFg,
    ),
    _LeaveBalance(
      name: 'Vacation Leave',
      left: 4,
      used: 4,
      bg: AppColors.calanderBgGreen,
      fg: AppColors.statusSuccessText,
    ),
  ];

  static const List<_LeaveRecord> _history = <_LeaveRecord>[
    _LeaveRecord(
      id: 'TR-202606',
      title: 'Casual Leave',
      approver: 'Olivia Rhye',
      dateLabel: 'Raised',
      date: '21 Jun 2026',
    ),
    _LeaveRecord(
      id: 'TR-202606',
      title: 'Maternity leave',
      approver: 'Olivia Rhye',
      dateLabel: 'Approved On',
      date: '21 Jun 2026',
    ),
    _LeaveRecord(
      id: 'TR-202606',
      title: 'Annual Leave',
      approver: 'Olivia Rhye',
      dateLabel: 'Approved On',
      date: '21 Jun 2026',
    ),
    _LeaveRecord(
      id: 'TR-202606',
      title: 'Optional Leave',
      approver: 'Olivia Rhye',
      dateLabel: 'Approved On',
      date: '21 Jun 2026',
    ),
  ];

  void _onApplyLeave() {}

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(title: 'My Leaves', textTheme: textTheme),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            pageBackground(),
            pageForeground(textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  Widget pageBackground() {
    return SvgPicture.asset(
      AppAssets.familyPageBg,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget pageForeground({required TextTheme textTheme}) {
    return Positioned(
      top: 101.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 12.r,
              spreadRadius: 0.r,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        'Leave Summary',
                        style: textTheme.geist14Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    for (final _LeaveBalance balance in _balances)
                      _BalanceBar(balance: balance),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        'Leave History',
                        style: textTheme.geist14Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    for (final _LeaveRecord record in _history)
                      _HistoryCard(record: record),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
              child: CustomButton(
                textStyle: textTheme.geist14Regular,
                buttonName: 'Apply Leave',
                size: AppButtonSize.large,
                variant: AppButtonVariant.secondary,
                borderRadius: 60.r,
                height: 56.h,
                onTap: _onApplyLeave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceBar extends StatelessWidget {
  const _BalanceBar({required this.balance});

  final _LeaveBalance balance;

  double _textWidth(BuildContext context, String text, TextStyle style) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    return painter.width;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle leftStyle = textTheme.geist12Regular.copyWith(
      color: balance.fg,
    );
    final TextStyle usedStyle = textTheme.geist12Regular.copyWith(
      color: AppColors.appBarTitleColor,
    );

    final String leftText = '${balance.left} left';
    final String usedText = '${balance.used} Used';

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double gap = 6.w;
          final double innerGap = 8.w;
          final double hPadding = 12.w * 2;
          final double available = constraints.maxWidth - gap;
          final int total = balance.left + balance.used;

          // Minimum width each bar needs so its text never overflows.
          final double leftMin =
              hPadding +
              _textWidth(context, balance.name, leftStyle) +
              innerGap +
              _textWidth(context, leftText, leftStyle) +
              2;
          final double usedMin =
              hPadding + _textWidth(context, usedText, usedStyle) + 2;

          double leftWidth = total == 0
              ? available / 2
              : available * balance.left / total;
          double usedWidth = available - leftWidth;

          if (leftWidth < leftMin) {
            leftWidth = leftMin;
            usedWidth = available - leftWidth;
          } else if (usedWidth < usedMin) {
            usedWidth = usedMin;
            leftWidth = available - usedWidth;
          }

          return Row(
            children: <Widget>[
              Container(
                width: leftWidth,
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: balance.bg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        balance.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: leftStyle,
                      ),
                    ),
                    SizedBox(width: innerGap),
                    Text(leftText, maxLines: 1, style: leftStyle),
                  ],
                ),
              ),
              SizedBox(width: gap),
              Container(
                width: usedWidth,
                height: 30.h,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(usedText, maxLines: 1, style: usedStyle),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.record});

  final _LeaveRecord record;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle label = textTheme.geist12Regular.copyWith(
      color: AppColors.toastMessage,
    );
    final TextStyle value = textTheme.geist12Regular.copyWith(
      color: AppColors.statusNeutralText,
    );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: AppColors.statusInfoSoft,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              record.id,
              style: textTheme.geist10Regular.copyWith(
                color: AppColors.toastMessage,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  record.title,
                  style: textTheme.geist14Medium.copyWith(
                    color: AppColors.cardTitleBlack,
                  ),
                ),
              ),
              Container(
                width: 6.r,
                height: 6.r,
                decoration: const BoxDecoration(
                  color: AppColors.toastSuccess,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Approved',
                style: textTheme.geist12Regular.copyWith(
                  color: AppColors.toastSuccess,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: <Widget>[
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: 'Approver  ',
                    style: label,
                    children: <InlineSpan>[
                      TextSpan(text: record.approver, style: value),
                    ],
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: '${record.dateLabel}  ',
                  style: label,
                  children: <InlineSpan>[
                    TextSpan(text: record.date, style: value),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
