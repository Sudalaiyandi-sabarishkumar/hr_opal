import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../models/amount_data.dart';
import '../profile/family_address_details.dart';

class PaySlipsPage extends StatefulWidget {
  const PaySlipsPage({super.key});

  @override
  State<PaySlipsPage> createState() => _PaySlipsPageState();
}

class _PaySlipsPageState extends State<PaySlipsPage> {
  DateTime _selectedMonth = DateTime(2026, 7);

  int _animationDirection = 1;

  static const List<AmountData> staticData = <AmountData>[
    AmountData(field: 'Basic Salary', amount: '62,500'),
    AmountData(field: 'House Rent Allowance (HRA)', amount: '25,500'),
    AmountData(field: 'Fixed Allowance', amount: '18,750'),
    AmountData(field: 'Special Allowance', amount: '18,750'),
  ];

  static const List<AmountData> staticData2 = <AmountData>[
    AmountData(field: 'PF Employee', amount: '62,500'),
    AmountData(field: 'Special Allowance', amount: '25,500'),
  ];

  static const List<AmountData> staticData3 = <AmountData>[
    AmountData(field: 'Provident Fund (PF)', amount: '62,500'),
    AmountData(field: 'ESI', amount: '938'),
    AmountData(field: 'Income Tax (TDS)', amount: '8,333'),
    AmountData(field: 'Professional Tax', amount: '200'),
    AmountData(field: 'Other Deductions', amount: '1,279'),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(title: 'My Payslips', textTheme: textTheme),
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
        padding: EdgeInsets.symmetric(horizontal: 17.w).copyWith(top: 24.h),
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
            datePickerRow(
              textTheme: textTheme,
              monthYear: _monthYearText(_selectedMonth),
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                reverseDuration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                layoutBuilder:
                    (Widget? currentChild, List<Widget> previousChildren) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final Animation<Offset> slideAnimation =
                      Tween<Offset>(
                        begin: Offset(
                          _animationDirection > 0 ? 0.12 : -0.12,
                          0,
                        ),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      );
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: child,
                    ),
                  );
                },
                child: _payslipContent(
                  textTheme: textTheme,
                  key: ValueKey<String>(_monthKey(_selectedMonth)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payslipContent({required TextTheme textTheme, required Key key}) {
    return SingleChildScrollView(
      key: key,
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          cardHeading(textTheme: textTheme, heading: 'Earnings'),
          SizedBox(height: 9.h),
          cardBody(
            textTheme: textTheme,
            amountData: staticData,
            bodyTotal: const AmountData(
              field: 'Gross Salary (A)',
              amount: '1,25,000',
            ),
          ),
          SizedBox(height: 18.h),
          cardHeading(textTheme: textTheme, heading: 'Contributions'),
          SizedBox(height: 9.h),
          cardBody(
            textTheme: textTheme,
            amountData: staticData2,
            bodyTotal: const AmountData(
              field: 'Total contributions (B)',
              amount: '1,25,000',
            ),
          ),
          SizedBox(height: 18.h),
          cardHeading(textTheme: textTheme, heading: 'Deductions'),
          SizedBox(height: 9.h),
          cardBody(
            textTheme: textTheme,
            amountData: staticData3,
            bodyTotal: const AmountData(
              field: 'Total Deductions (C)',
              amount: '18,250',
            ),
          ),
          SizedBox(height: 18.h),
          grandTotalWidget(
            textTheme: textTheme,
            amount: '1,06,750',
            amountInWords: 'One lakh six thousand seven fifty rupees',
          ),
          SizedBox(height: 18.h),
          footerText(textTheme: textTheme),
        ],
      ),
    );
  }

  Widget cardHeading({required TextTheme textTheme, required String heading}) {
    return Text(
      heading,
      style: textTheme.geist12SemiBold.copyWith(color: AppColors.secondary500),
      textAlign: TextAlign.left,
    );
  }

  Widget cardBody({
    required TextTheme textTheme,
    required List<AmountData> amountData,
    required AmountData bodyTotal,
  }) {
    final TextStyle amountStyle = textTheme.geist12Regular.copyWith(
      color: AppColors.toastMessage,
    );

    final TextStyle totalAmountStyle = textTheme.geist12SemiBold.copyWith(
      fontSize: 13.sp,
      color: AppColors.darkBlue,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1.w, color: AppColors.statusSoftBg),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 9.h),
            child: Column(
              children: <Widget>[
                for (
                  int index = 0;
                  index < amountData.length;
                  index++
                ) ...<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          amountData[index].field,
                          style: amountStyle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(text: '₹', style: amountStyle),
                            TextSpan(
                              text: amountData[index].amount,
                              style: amountStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (index != amountData.length - 1) SizedBox(height: 9.h),
                ],
              ],
            ),
          ),
          SizedBox(height: 9.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.neutral50,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    bodyTotal.field,
                    style: textTheme.geist12SemiBold.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: '₹', style: totalAmountStyle),
                      TextSpan(text: bodyTotal.amount, style: totalAmountStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget grandTotalWidget({
    required TextTheme textTheme,
    required String amount,
    required String amountInWords,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary500,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Text(
              'Net Salary Payable\n(A - B - C)',
              style: textTheme.geist14Medium.copyWith(
                color: AppColors.white,
                fontFamily: 'HostGrotesk',
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 5,
            child: Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '₹ $amount',
                  textAlign: TextAlign.end,
                  style: textTheme.geist18Bold.copyWith(color: AppColors.white),
                ),
                Text(
                  amountInWords,
                  textAlign: TextAlign.end,
                  softWrap: true,
                  style: textTheme.geist12Regular.copyWith(
                    color: AppColors.shadowScroll,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget footerText({required TextTheme textTheme}) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '*This is computer generated statement, does not require signature.',
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.toastMessage,
          ),
        ),
        Text(
          '**Note : All amounts displayed in this payslip are in INR',
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.toastMessage,
          ),
        ),
      ],
    );
  }

  Widget datePickerRow({
    required TextTheme textTheme,
    required String monthYear,
  }) {
    return SizedBox(
      height: 30.r,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _showPreviousMonth,
                child: SizedBox(
                  width: 30.r,
                  height: 30.r,
                  child: Center(
                    child: SvgPicture.asset(AppAssets.chevronLeftIcon),
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  monthYear,
                  key: ValueKey<String>(monthYear),
                  style: textTheme.geist14Medium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _showNextMonth,
                child: SizedBox(
                  width: 30.r,
                  height: 30.r,
                  child: Center(
                    child: SvgPicture.asset(AppAssets.chevronRightIcon),
                  ),
                ),
              ),
            ],
          ),
          Positioned(right: 0, child: downloadIcon()),
        ],
      ),
    );
  }

  Widget downloadIcon() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 30.r,
        width: 30.r,
        decoration: BoxDecoration(
          color: AppColors.liteGrey,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Center(child: SvgPicture.asset(AppAssets.downloadIcon)),
      ),
    );
  }

  void _showPreviousMonth() {
    setState(() {
      _animationDirection = -1;
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _showNextMonth() {
    setState(() {
      _animationDirection = 1;
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    });
  }

  String _monthYearText(DateTime date) {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }

  String _monthKey(DateTime date) {
    return '${date.year}-${date.month}';
  }
}
