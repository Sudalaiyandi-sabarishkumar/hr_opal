import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import 'payroll_widgets.dart';

class PayrollPage extends StatefulWidget {
  const PayrollPage({
    super.key,
    this.annualPay = '18,50,000',
    this.dateLabel = 'Tue 12',
    this.temperature = '23°',
  });

  final String annualPay;
  final String dateLabel;
  final String temperature;

  @override
  State<PayrollPage> createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {
  bool _showPay = false;

  static const List<TaxBreakdownItem> _taxItems = <TaxBreakdownItem>[
    TaxBreakdownItem(label: 'Income Tax', amount: '₹32,500'),
    TaxBreakdownItem(label: 'Professional Tax', amount: '₹2,400'),
    TaxBreakdownItem(label: 'Social Security', amount: '₹10,300'),
  ];

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,

            child: Image.asset(AppAssets.bg4Image, fit: BoxFit.cover),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h + bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTopBar(textTheme),
                  SizedBox(height: 28.h),
                  _buildAnnualPay(textTheme),
                  SizedBox(height: 28.h),
                  _buildQuickActions(textTheme),
                  SizedBox(height: 32.h),
                  _buildExpenseRequests(textTheme),
                  SizedBox(height: 28.h),
                  _buildTaxSummary(textTheme),
                  SizedBox(height: 24.h),
                  _buildTaxForms(textTheme),
                  SizedBox(height: 24.h),
                  _buildPreviousDeclarations(textTheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              context.push(RouteConstants.profilePage);
            },
            child: Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.7),
                  width: 0.5.w,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.femaleImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                widget.dateLabel,
                style: textTheme.geist13Regular.copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(width: 10.w),
              SvgPicture.asset(
                AppAssets.payrollCloud,
                width: 16.r,
                height: 16.r,
                colorFilter: ColorFilter.mode(
                  AppColors.white.withValues(alpha: 0.9),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                widget.temperature,
                style: textTheme.geist13Regular.copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              SvgPicture.asset(
                AppAssets.profileNotification,
                width: 24.r,
                height: 24.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: AppColors.notificationDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnualPay(TextTheme textTheme) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'My Annual Pay',
            style: textTheme.geist13Regular.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '₹',
                style: textTheme.geist34Bold.copyWith(color: AppColors.white),
              ),
              SizedBox(width: 10.w),
              if (_showPay)
                Text(
                  widget.annualPay,
                  style: textTheme.geist30Bold.copyWith(color: AppColors.white),
                )
              else
                Row(
                  children: List<Widget>.generate(
                    6,
                    (int i) => Container(
                      width: 9.r,
                      height: 9.r,
                      margin: EdgeInsets.only(right: i == 5 ? 0 : 8.w),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: () => setState(() => _showPay = !_showPay),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _showPay ? 'Hide' : 'Show',
                style: textTheme.geist10Regular.copyWith(
                  color: AppColors.payrollInk,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _QuickAction(
              textTheme: textTheme,
              label: 'My Payslips',
              asset: AppAssets.payrollPayslips,
              onTap: () {
                context.push(RouteConstants.payslipsPage);
              },
            ),
          ),
          Expanded(
            child: _QuickAction(
              textTheme: textTheme,
              label: 'Pay Breakdown',
              asset: AppAssets.payrollPayBreakdown,
              onTap: () {
                context.push(RouteConstants.payBreakdownPage);
              },
            ),
          ),
          Expanded(
            child: _QuickAction(
              textTheme: textTheme,
              label: 'Expense Request',
              asset: AppAssets.payrollExpenseRequest,
              onTap: () {
                context.push(RouteConstants.expenseRequest);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseRequests(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionLabel('My Expense Requests'),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[
              Expanded(
                child: RequestCard(
                  requestId: 'TR-202606',
                  title: 'Expense Request',
                  status: RequestStatus.pending,
                  ownerName: 'Olivia Rhye',
                  onTap: () {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: RequestCard(
                  requestId: 'TR-202606',
                  title: 'Expense Request',
                  status: RequestStatus.approved,
                  ownerName: 'Olivia Rhye',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSummary(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Tax Summary',
                style: textTheme.geist18SemiBold.copyWith(
                  color: AppColors.payrollInk,
                  fontFamily: hostGroteskFont,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.statusInfoSoft,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'FY 2025-26',
                  style: textTheme.geist12Regular.copyWith(
                    color: AppColors.statusInfo,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const TaxSummaryCard(
            totalLabel: 'Total Tax Paid',
            totalAmount: '₹45,200',
            items: _taxItems,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxForms(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tax Forms',
            style: textTheme.geist14Medium.copyWith(
              color: AppColors.statusNeutralText,
              fontFamily: hostGroteskFont,
            ),
          ),
          SizedBox(height: 12.h),
          TaxFormCard(
            title: 'Form 16 (2025-26)',
            subtitle: 'Annual Salary Certificate • PDF',
            onDownload: () {},
          ),
          SizedBox(height: 8.h),
          TaxFormCard(
            title: 'Form 12BB',
            subtitle: 'Investment Declaration Draft • PDF',
            onDownload: () {},
          ),
          SizedBox(height: 8.h),
          TaxFormCard(
            title: 'Investment Declaration',
            subtitle: 'FY 2025-26 Submitted Form • PDF',
            onDownload: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousDeclarations(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Previous Declarations',
            style: textTheme.geist14Medium.copyWith(
              color: AppColors.statusNeutralText,
            ),
          ),
          SizedBox(height: 4.h),
          DeclarationTile(
            year: 'FY 2023-24',
            status: RequestStatus.pending,
            onTap: () {},
          ),
          DeclarationTile(
            year: 'FY 2025-26',
            status: RequestStatus.filed,
            onTap: () {},
          ),
          DeclarationTile(
            year: 'FY 2024-25',
            status: RequestStatus.filed,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.geist12Regular
          .copyWith(color: AppColors.textPrimary),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.textTheme,
    required this.label,
    required this.asset,
    required this.onTap,
  });

  final TextTheme textTheme;
  final String label;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.55),
            ),
            child: Center(
              child: SvgPicture.asset(
                asset,
                width: 22.r,
                height: 22.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.payrollQuickActionIcon,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.geist12Regular.copyWith(
              color: AppColors.payrollInk,
            ),
          ),
        ],
      ),
    );
  }
}
