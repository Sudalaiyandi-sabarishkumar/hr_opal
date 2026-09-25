import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/info_card/app_info_card2.dart';

class AssetItem {
  const AssetItem({
    required this.name,
    required this.status,
    required this.issuedOn,
    required this.returnDate,
    required this.damageCharges,
    required this.remarks,
    required this.headerColor,
    this.statusColor = AppColors.assetActiveGreen,
  });

  final String name;
  final String status;
  final String issuedOn;
  final String returnDate;
  final String damageCharges;
  final String remarks;
  final Color headerColor;
  final Color statusColor;
}

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({
    super.key,
    this.assets = const <AssetItem>[
      AssetItem(
        name: 'Mobile Device',
        status: 'Active',
        issuedOn: '12 Dec 2026',
        returnDate: '12 Jan 2027',
        damageCharges: '-',
        remarks: 'In Good Condition',
        headerColor: AppColors.assetHeaderPurple,
      ),
      AssetItem(
        name: 'Laptop',
        status: 'Active',
        issuedOn: '12 Dec 2026',
        returnDate: '12 Jan 2027',
        damageCharges: '-',
        remarks: 'In Good Condition',
        headerColor: AppColors.assetHeaderGreen,
      ),
      AssetItem(
        name: 'Wireless Mouse',
        status: 'Active',
        issuedOn: '12 Dec 2026',
        returnDate: '12 Jan 2027',
        damageCharges: '-',
        remarks: 'In Good Condition',
        headerColor: AppColors.assetHeaderYellow,
      ),
    ],
  });

  final List<AssetItem> assets;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Assets',
      titleColor: AppColors.headerTitleNavy,
      gradient: AppHeaderGradient.lavender,
      backButtonHasBorder: true,
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
        itemCount: assets.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (BuildContext context, int index) {
          return _AssetCard(asset: assets[index]);
        },
      ),
    );
  }
}

class _AssetCard extends StatelessWidget {
  const _AssetCard({required this.asset});

  final AssetItem asset;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppInfoCard2(
      headerColor: asset.headerColor,
      header: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              asset.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.geist14Medium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          _StatusChip(label: asset.status, color: asset.statusColor),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LabelValueRow(label: 'Issued On', value: asset.issuedOn),
          LabelValueRow(label: 'Return Date', value: asset.returnDate),
          LabelValueRow(label: 'Damage Charges', value: asset.damageCharges),
          LabelValueRow(label: 'Remarks', value: asset.remarks),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.w),
          Text(
            label,
            style: textTheme.geist12Medium.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}