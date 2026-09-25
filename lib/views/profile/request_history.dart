import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/info_card/app_info_card2.dart';
import '../../shared_components/search_filter/app_search_filter.dart';

class RequestHistoryItem {
  const RequestHistoryItem({
    required this.title,
    required this.tag,
    required this.status,
    required this.requestedOn,
    required this.approvedBy,
    required this.approvedOn,
    required this.description,
    this.threeColumnLayout = false,
  });

  final String title;
  final String tag;
  final String status;
  final String requestedOn;
  final String approvedBy;
  final String approvedOn;
  final String description;



  final bool threeColumnLayout;
}

class RequestsHistoryScreen extends StatelessWidget {
  const RequestsHistoryScreen({
    super.key,
    this.requests = const <RequestHistoryItem>[
      RequestHistoryItem(
        title: 'Loan Request',
        tag: 'Personal Loan',
        status: 'Active',
        requestedOn: '12 Dec 2026',
        approvedBy: 'Lori Wharf',
        approvedOn: '12 Dec 2026',
        description: 'Employment Verification Letter issued',
      ),
      RequestHistoryItem(
        title: 'Bank Account Change',
        tag: 'Bank Account',
        status: 'Active',
        requestedOn: '12 Dec 2026',
        approvedBy: 'Lori Wharf',
        approvedOn: '12 Dec 2026',
        description: 'Leave credit for Holiday \u2013 Apr 14',
        threeColumnLayout: true,
      ),
    ],
  });

  final List<RequestHistoryItem> requests;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'Requests History',
      headerHeight: 150,
      titleStyle: textTheme.geist20SemiBold.copyWith(
        color: AppColors.textPrimary,
        fontFamily: hostGroteskFont,
      ),
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
              itemCount: requests.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (BuildContext context, int index) {
                return _RequestCard(item: requests[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.item});

  final RequestHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppInfoCard2(
      headerColor: AppColors.purple2,
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: textTheme.geist14SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                AppTagChip(
                  label: item.tag,
                  background: AppColors.amendmentPurpleBg,
                  foreground: AppColors.amendmentPurple,
                ),
              ],
            ),
          ),
          AppStatusBadge(label: item.status),
        ],
      ),
      body: item.threeColumnLayout
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: LabeledValueBlock(
                        label: 'Requested On',
                        value: item.requestedOn,
                      ),
                    ),
                    Expanded(
                      child: LabeledValueBlock(
                        label: 'Approved By',
                        value: item.approvedBy,
                      ),
                    ),
                    Expanded(
                      child: LabeledValueBlock(
                        label: 'Approved On',
                        value: item.approvedOn,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                LabeledValueBlock(
                  label: 'Description',
                  value: item.description,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LabeledValueBlock(
                  label: 'Requested On',
                  value: item.requestedOn,
                ),
                SizedBox(height: 12.h),
                LabeledValueBlock(
                  label: 'Approved By',
                  value: item.approvedBy,
                ),
                SizedBox(height: 12.h),
                LabeledValueBlock(
                  label: 'Approved On',
                  value: item.approvedOn,
                ),
                SizedBox(height: 12.h),
                LabeledValueBlock(
                  label: 'Description',
                  value: item.description,
                ),
              ],
            ),
    );
  }
}