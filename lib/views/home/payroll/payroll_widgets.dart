import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';

enum RequestStatus { pending, approved, rejected, filed }

extension RequestStatusX on RequestStatus {
  String get label => switch (this) {
    RequestStatus.pending => 'Pending',
    RequestStatus.approved => 'Approved',
    RequestStatus.rejected => 'Rejected',
    RequestStatus.filed => 'Filed',
  };

  Color get color => switch (this) {
    RequestStatus.pending => AppColors.statusWarning,
    RequestStatus.approved => AppColors.statusSuccess,
    RequestStatus.rejected => AppColors.statusDanger,
    RequestStatus.filed => AppColors.statusSuccess,
  };
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.filled = true});

  final RequestStatus status;

  final bool filled;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: filled ? 3.w : 0,
        vertical: filled ? 2.h : 0,
      ),
      decoration: BoxDecoration(
        color: filled ? AppColors.white : AppColors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 7.r,
            height: 7.r,
            decoration: BoxDecoration(
              color: status.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            status.label,
            style: textTheme.geist12Medium.copyWith(
              color: status.color,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.requestId,
    required this.title,
    required this.status,
    required this.ownerName,
    this.onTap,
  });

  final String requestId;
  final String title;
  final RequestStatus status;
  final String ownerName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: AppColors.payrollRequestCardBg,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.payrollRequestCardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.statusInfoSoft,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  requestId,
                  style: textTheme.geist10Regular.copyWith(
                    color: AppColors.toastMessage,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: textTheme.geist14Medium.copyWith(
                  color: AppColors.cardTitleBlack,
                  fontFamily: hostGroteskFont,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: <Widget>[
                  StatusBadge(status: status),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      ownerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.geist12Regular.copyWith(
                        color: AppColors.statusNeutralText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaxBreakdownItem {
  const TaxBreakdownItem({required this.label, required this.amount});
  final String label;
  final String amount;
}

class TaxSummaryCard extends StatelessWidget {
  const TaxSummaryCard({
    super.key,
    required this.totalLabel,
    required this.totalAmount,
    required this.items,
  });

  final String totalLabel;
  final String totalAmount;
  final List<TaxBreakdownItem> items;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.payrollSummaryBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.payrollSummaryBorder),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalLabel,
                style: textTheme.geist14Medium.copyWith(
                  color: AppColors.statusNeutralText,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                totalAmount,
                style: textTheme.geist18SemiBold.copyWith(
                  color: AppColors.textPrimary,
                  fontFamily: hostGroteskFont,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.payrollSummaryBorder,
            ),
          ),
          for (int i = 0; i < items.length; i++) ...<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  items[i].label,
                  style: textTheme.geist13Regular.copyWith(
                    color: AppColors.toastMessage,
                  ),
                ),
                Text(
                  items[i].amount,
                  style: textTheme.geist13Regular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            if (i != items.length - 1) SizedBox(height: 12.h),
          ],
        ],
      ),
    );
  }
}

class TaxFormCard extends StatelessWidget {
  const TaxFormCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onDownload,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: AppColors.payrollFormCardBg,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(AppAssets.payrollPdf, width: 30.r, height: 34.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: textTheme.geist12Medium.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: textTheme.geist12Regular.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onDownload,
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: SvgPicture.asset(
                    AppAssets.payrollDownload,
                    width: 20.r,
                    height: 20.r,
                    colorFilter: const ColorFilter.mode(
                      AppColors.payrollSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeclarationTile extends StatelessWidget {
  const DeclarationTile({
    super.key,
    required this.year,
    required this.status,
    this.onTap,
  });

  final String year;
  final RequestStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 92.w,
              child: Text(
                year,
                style: textTheme.geist12Regular.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            StatusBadge(status: status, filled: false),
            const Spacer(),
            SvgPicture.asset(
              AppAssets.payrollChevronRight,
              width: 16.w,
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                AppColors.payrollSecondary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
