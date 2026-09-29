import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../models/policy_model.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import 'updated_policies.dart';


class _PolicyStyle {
  const _PolicyStyle(this.iconAsset, this.iconBg, this.previewBg);

  final String iconAsset;
  final Color iconBg;
  final Color previewBg;
}

extension on PolicyType {
  _PolicyStyle get style {
    switch (this) {
      case PolicyType.bonus:
        return const _PolicyStyle(
          AppAssets.moneyBag,
          AppColors.bonusIconbg,
          AppColors.lightPurple,
        );
      case PolicyType.leave:
        return const _PolicyStyle(
          AppAssets.beachGreen,
          AppColors.cardFooterGreen,
          AppColors.lightGreen,
        );
      case PolicyType.holiday:
        return const _PolicyStyle(
          AppAssets.calendarRed,
        AppColors.statusWarningSubtleBg,
          AppColors.lightYellow,
        );
      case PolicyType.other:
        return const _PolicyStyle(
          AppAssets.calendarRed,
          AppColors.statusWarningSubtleBg,
          AppColors.lightYellow,
        );
    }
  }
}

class HrPoliciesPage extends StatelessWidget {
  const HrPoliciesPage({super.key, this.policies = samplePolicies});

  final List<PolicyModel> policies;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'HR Policies',
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
          itemCount: policies.length,
          separatorBuilder: (_, __) => SizedBox(height: 24.h),
          itemBuilder: (BuildContext context, int index) {
            final PolicyModel policy = policies[index];
            return Center(
              child: PolicyCard(
                policy: policy,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => UpdatedPolicyPage(policy: policy,showAcknowledgmentNotice: true,),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PolicyCard extends StatelessWidget {
  const PolicyCard({super.key, required this.policy, required this.onTap});

  final PolicyModel policy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final _PolicyStyle style = policy.type.style;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 348.w,
        height: 209.h,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.neutral25,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.neutral50),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: style.previewBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.only(top: 20.h, left: 40.w, right: 40.w),
                child: _DocumentThumbnail(policy: policy),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: <Widget>[
                Container(
                  width: 40.r,
                  height: 40.r,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: style.iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(style.iconAsset),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        policy.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.geist12Regular.copyWith(
                          color: AppColors.statusNeutralText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Last updated - ${policy.lastUpdated}',
                        style: textTheme.geist10Regular.copyWith(
                          color: AppColors.neutral300
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _DocumentThumbnail extends StatelessWidget {
  const _DocumentThumbnail({required this.policy});

  final PolicyModel policy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle bodyStyle =
        textTheme.geist10Regular.copyWith(fontSize: 6.sp);
    final TextStyle boldStyle =
        textTheme.geist10SemiBold.copyWith(fontSize: 6.sp);

    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.topCenter,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
             boxShadow: const <BoxShadow>[
    BoxShadow(
      color: Color(0xCC000000), 
      offset: Offset(0, -2),    
      blurRadius: 5,           
      spreadRadius: -8,        
    ),
  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  policy.documentTitle,
                  style: textTheme.geist10SemiBold,
                ),
              ),
              SizedBox(height: 8.h),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: 'Created by: ', style: boldStyle),
                    TextSpan(text: policy.createdBy),
                  ],
                ),
                style: bodyStyle,
              ),
              SizedBox(height: 4.h),
              Text(
                'For any queries regarding this policy, please reach out to us at ${policy.contactEmail}',
                style: bodyStyle,
              ),
              
              for (final PolicySection s
                  in policy.sections.take(2)) ...<Widget>[
                SizedBox(height: 8.h),
                Text(
                  s.heading,
                  style: textTheme.geist10SemiBold.copyWith(fontSize: 8.sp),
                ),
                SizedBox(height: 3.h),
                Text(s.body, style: bodyStyle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
