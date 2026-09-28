import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../models/amount_data.dart';

class PayslipCardBody extends StatelessWidget {
  const PayslipCardBody({
    super.key,
    required this.amountData,
    required this.bodyTotal,
    required this.textTheme,
    this.maskAmount = false,
  });

  final List<AmountData> amountData;
  final AmountData bodyTotal;
  final TextTheme textTheme;
  final bool maskAmount;

  String _displayAmount(String amount) {
    if (!maskAmount) {
      return '₹$amount';
    }

    return '₹${'•' * amount.length}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1.w, color: AppColors.statusSoftBg),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w)
                .copyWith(top: 9.h, bottom: 9.h),
            child: Column(
              children: [
                for (int index = 0; index < amountData.length; index++) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          amountData[index].field,
                          style: textTheme.geist12Regular.copyWith(
                            color: AppColors.toastMessage,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        _displayAmount(amountData[index].amount),
                        style: textTheme.geist12Regular.copyWith(
                          color: AppColors.toastMessage,
                        ),
                      ),
                    ],
                  ),

                  if (index != amountData.length - 1) SizedBox(height: 9.h),
                ],
              ],
            ),
          ),

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    bodyTotal.field,
                    style: textTheme.geist12SemiBold.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  _displayAmount(bodyTotal.amount),
                  style: textTheme.geist12SemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PayslipCardHeading extends StatelessWidget {
  const PayslipCardHeading({
    super.key,
    required this.textTheme,
    required this.heading,
  });

  final TextTheme textTheme;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      textAlign: TextAlign.left,
      style: textTheme.geist12SemiBold.copyWith(color: AppColors.secondary500),
    );
  }
}

class PayslipGrandTotal extends StatelessWidget {
  const PayslipGrandTotal({
    super.key,
    required this.textTheme,
    required this.amount,
    required this.amountInWords,
    this.maskAmount = false,
  });

  final TextTheme textTheme;
  final String amount;
  final String amountInWords;
  final bool maskAmount;

  String get _displayAmount {
    if (!maskAmount) {
      return '₹$amount';
    }
    final int characterCount = amount.length;
    return '₹${'•' * characterCount}';
  }

  @override
  Widget build(BuildContext context) {
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
            flex: 6,
            child: Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _displayAmount,
                  textAlign: TextAlign.end,
                  style: textTheme.geist18Bold.copyWith(color: AppColors.white),
                ),
                if (!maskAmount)
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
}
