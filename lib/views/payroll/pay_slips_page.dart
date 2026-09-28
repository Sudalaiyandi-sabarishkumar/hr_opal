import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../models/amount_data.dart';
import '../profile/family_address_details.dart';
import 'pay_slip_card_body.dart';

class PaySlipsPage extends StatefulWidget {
  const PaySlipsPage({super.key});

  @override
  State<PaySlipsPage> createState() => _PaySlipsPageState();
}

class _PaySlipsPageState extends State<PaySlipsPage> {
  DateTime _selectedMonth = DateTime(2026, 7);

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
              child: _payslipContent(
                textTheme: textTheme,
                key: ValueKey<String>(_monthKey(_selectedMonth)),
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
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PayslipCardHeading(textTheme: textTheme, heading: 'Earnings'),
          SizedBox(height: 9.h),
          PayslipCardBody(
            textTheme: textTheme,
            amountData: staticData,
            bodyTotal: const AmountData(
              field: 'Gross Salary (A)',
              amount: '1,25,000',
            ),
          ),
          SizedBox(height: 18.h),
          PayslipCardHeading(textTheme: textTheme, heading: 'Contributions'),
          SizedBox(height: 9.h),
          PayslipCardBody(
            textTheme: textTheme,
            amountData: staticData2,
            bodyTotal: const AmountData(
              field: 'Total contributions (B)',
              amount: '1,25,000',
            ),
          ),
          SizedBox(height: 18.h),
          PayslipCardHeading(textTheme: textTheme, heading: 'Deductions'),
          SizedBox(height: 9.h),
          PayslipCardBody(
            textTheme: textTheme,
            amountData: staticData3,
            bodyTotal: const AmountData(
              field: 'Total Deductions (C)',
              amount: '18,250',
            ),
          ),
          SizedBox(height: 18.h),
          PayslipGrandTotal(
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
              Text(
                monthYear,
                style: textTheme.geist14Medium.copyWith(
                  color: AppColors.textPrimary,
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
      behavior: HitTestBehavior.opaque,
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
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _showNextMonth() {
    setState(() {
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
