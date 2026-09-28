import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../models/amount_data.dart';
import '../../shared_components/tabs/app_segmented_tabs.dart';
import '../../shared_components/toggle/app_toggle.dart';
import '../profile/family_address_details.dart';
import 'pay_slip_card_body.dart';

class PayBreakdownPage extends StatefulWidget {
  const PayBreakdownPage({super.key});

  @override
  State<PayBreakdownPage> createState() => _PayBreakdownPageState();
}

class _PayBreakdownPageState extends State<PayBreakdownPage> {
  bool _hideInfo = true;

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
      appBar: ProfileAppBar(title: 'Pay Breakdown', textTheme: textTheme),
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
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            children: <Widget>[
              hideInfoToggle(textTheme: textTheme),
              SizedBox(height: 28.h),
              mySalaryDisplay(
                textTheme: textTheme,
                amount: '1,06,750',
                maskAmount: _hideInfo,
              ),
              SizedBox(height: 49.h),
              pieChartGraph(textTheme: textTheme),
              SizedBox(height: 32.h),
              allGraphCodes(textTheme: textTheme),
              SizedBox(height: 48.h),
              AppSegmentedTabs(
                labels: const ['Monthly', 'Annually'],
                selectedIndex: 0,
                onChanged: (int index) {},
              ),
              SizedBox(height: 26.h),
              payslipContent(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget hideInfoToggle({required TextTheme textTheme}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.purple3,
        border: Border.all(width: 1.w, color: AppColors.statusInfoSoft),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hide sensitive salary information',
            style: textTheme.geist12Medium.copyWith(
              color: AppColors.textPrimary,
              fontSize: 13.sp,
            ),
          ),
          AppToggle(
            value: _hideInfo,
            onChanged: (bool value) {
              setState(() {
                _hideInfo = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget mySalaryDisplay({
    required TextTheme textTheme,
    required String amount,
    bool maskAmount = false,
  }) {
    return Column(
      spacing: 5.h,
      children: [
        Text(
          'My Salary',
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.statusNeutralText,
          ),
        ),
        Text(
          displayAmount(maskAmount, amount),
          style: textTheme.geist32SemiBold.copyWith(
            color: AppColors.cardTitleBlack,
            fontSize: 30.sp,
          ),
        ),
      ],
    );
  }

  String displayAmount(bool maskAmount, String amount) {
    if (!maskAmount) {
      return '₹ $amount';
    }
    final int characterCount = amount.length;
    return '₹ ${'•' * characterCount}';
  }

  Widget pieChartGraph({required TextTheme textTheme}) {
    final double outerRadius = 40.w;
    final double centerRadius = 60.w;

    return SizedBox(
      height: 202.r,
      width: 202.r,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: centerRadius.r,
          startDegreeOffset: 0,
          borderData: FlBorderData(show: false),
          sections: [
            PieChartSectionData(
              value: 40,
              color: AppColors.chartBlue1,
              radius: outerRadius.r,
              showTitle: false,
            ),
            PieChartSectionData(
              value: 20,
              color: AppColors.yellow1,
              radius: outerRadius.r,
              showTitle: false,
            ),
            PieChartSectionData(
              value: 17,
              color: AppColors.chartPurple,
              radius: outerRadius.r,
              showTitle: false,
            ),
            PieChartSectionData(
              value: 8,
              color: AppColors.chartGreen,
              radius: outerRadius.r,
              showTitle: false,
            ),
            PieChartSectionData(
              value: 5,
              color: AppColors.chartPink,
              radius: outerRadius.r,
              showTitle: false,
            ),
            PieChartSectionData(
              value: 10,
              color: AppColors.headingBlue,
              radius: outerRadius.r,
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget allGraphCodes({required TextTheme textTheme}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      child: Column(
        spacing: 8.h,
        children: [
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'Basic',
            value: '40',
            color: AppColors.chartBlue1,
          ),
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'HRA',
            value: '20',
            color: AppColors.yellow1,
          ),
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'Special Allowance',
            value: '17',
            color: AppColors.chartPurple,
          ),
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'Medical Allowance',
            value: '8',
            color: AppColors.chartGreen,
          ),
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'Conveyance Allowance',
            value: '5',
            color: AppColors.chartPink,
          ),
          singleGraphCodeRow(
            textTheme: textTheme,
            field: 'Other',
            value: '10',
            color: AppColors.headingBlue,
          ),
        ],
      ),
    );
  }

  Widget singleGraphCodeRow({
    required TextTheme textTheme,
    required String field,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            field,
            style: textTheme.geist14Regular.copyWith(
              color: AppColors.statusNeutralText,
            ),
          ),
        ),
        Text(
          '$value%',
          style: textTheme.geist14Regular.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget payslipContent({required TextTheme textTheme}) {
    return Column(
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
          maskAmount: _hideInfo,
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
          maskAmount: _hideInfo,
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
          maskAmount: _hideInfo,
        ),
        SizedBox(height: 18.h),
        PayslipGrandTotal(
          textTheme: textTheme,
          amount: '1,06,750',
          amountInWords: 'One lakh six thousand seven fifty rupees',
          maskAmount: _hideInfo,
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
