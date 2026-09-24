import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';

import '../shared_components/info_card/app_info_card2.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180.h,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.headerGradientLavenderTop,
                          AppColors.headerGradientLavenderMid,
                          AppColors.headerGradientLavenderBottom,
                        ],
                        stops: <double>[0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(1.0, 1.1),
                        radius: 0.7,
                        colors: <Color>[
                          AppColors.headerGlowPeach,
                          AppColors.headerGlowPeachTransparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                SizedBox(height: 39.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Text(
                      'Assets',
                      style: textTheme.geist18SemiBold.copyWith(
                        color: AppColors.headerTitleNavy,
                        fontFamily: hostGroteskFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                      itemCount: assets.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (BuildContext context, int index) {
                        return _AssetCard(asset: assets[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, top: 39.h),
              child: InkWell(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(color: AppColors.chipBorder),
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
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