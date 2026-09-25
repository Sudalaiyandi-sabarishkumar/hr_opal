import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/info_card/app_info_card2.dart';
import '../../shared_components/search_filter/app_search_filter.dart';

class Amendment {
  const Amendment({
    required this.fieldLabel,
    required this.oldValue,
    required this.newFieldLabel,
    required this.newValue,
    required this.effectiveDate,
    required this.createdBy,
    required this.createdOn,
    required this.lastModifiedBy,
    required this.lastModifiedOn,
    required this.accentBackground,
    required this.accentForeground,
    required this.newValueColor,
  });

  final String fieldLabel;
  final String oldValue;
  final String newFieldLabel;
  final String newValue;
  final String effectiveDate;
  final String createdBy;
  final String createdOn;
  final String lastModifiedBy;
  final String lastModifiedOn;
  final Color accentBackground;
  final Color accentForeground;
  final Color newValueColor;
}

class AmendmentsScreen extends StatelessWidget {
  const AmendmentsScreen({
    super.key,
    this.amendments = const <Amendment>[
      Amendment(
        fieldLabel: 'Company',
        oldValue: 'Accenture Solutions',
        newFieldLabel: 'New Company',
        newValue: 'Elxir Technology',
        effectiveDate: '12 Dec 2026',
        createdBy: 'Lori Wharf',
        createdOn: '12 Dec 2026',
        lastModifiedBy: 'James Hall',
        lastModifiedOn: '19 Dec 2026',
        accentBackground: AppColors.purple3,
        accentForeground: AppColors.purple1,
        newValueColor: AppColors.amendmentPurple,
      ),
      Amendment(
        fieldLabel: 'Designation',
        oldValue: 'SDE II',
        newFieldLabel: 'New Designation',
        newValue: 'Technical Lead',
        effectiveDate: '12 Dec 2026',
        createdBy: 'Lori Wharf',
        createdOn: '12 Dec 2026',
        lastModifiedBy: 'James Hall',
        lastModifiedOn: '19 Dec 2026',
        accentBackground: AppColors.amendmentPurpleBg,
        accentForeground: AppColors.amendmentPurpleFg,
        newValueColor: AppColors.amendmentPurple,
      ),
      Amendment(
        fieldLabel: 'Company',
        oldValue: 'Accenture Solutions',
        newFieldLabel: 'New Company',
        newValue: 'Elxir Technology',
        effectiveDate: '12 Dec 2026',
        createdBy: 'Lori Wharf',
        createdOn: '12 Dec 2026',
        lastModifiedBy: 'James Hall',
        lastModifiedOn: '19 Dec 2026',
        accentBackground: AppColors.amendmentYellowBg,
        accentForeground: AppColors.yellow1,
        newValueColor: AppColors.amendmentYellow,
      ),
    ],
  });

  final List<Amendment> amendments;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Amendments',
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: const AppSearchFilterBar(),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              itemCount: amendments.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (BuildContext context, int index) {
                return _AmendmentCard(amendment: amendments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AmendmentCard extends StatelessWidget {
  const _AmendmentCard({required this.amendment});

  final Amendment amendment;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppInfoCard2(
      headerColor: amendment.accentBackground,
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  amendment.fieldLabel,
                  style: textTheme.geist12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  amendment.oldValue,
                  style: textTheme.geist10Medium.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 13.sp
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AppAccentCircleIcon(
              background: amendment.accentForeground,
              foreground: AppColors.black,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  amendment.newFieldLabel,
                  style: textTheme.geist12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  amendment.newValue,
                  textAlign: TextAlign.right,
                  style: textTheme.geist10Medium.copyWith(
                    color: amendment.newValueColor,
                    fontSize: 13.sp

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LabelValueRow(
            label: 'Effective Date',
            value: amendment.effectiveDate,
          ),
          LabelValueRow(label: 'Created By', value: amendment.createdBy),
          LabelValueRow(label: 'Created On', value: amendment.createdOn),
          LabelValueRow(
            label: 'Last Modified by',
            value: amendment.lastModifiedBy,
          ),
          LabelValueRow(
            label: 'Last Modified on',
            value: amendment.lastModifiedOn,
          ),
        ],
      ),
    );
  }
}
