import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class ChipsShowcasePage extends StatelessWidget {
  const ChipsShowcasePage({super.key});

  static const List<AppBadgeColor> _colors = <AppBadgeColor>[
    AppBadgeColor.info,
    AppBadgeColor.neutral,
    AppBadgeColor.success,
    AppBadgeColor.warning,
    AppBadgeColor.danger,
  ];

  static const List<AppChipVariant> _variants = <AppChipVariant>[
    AppChipVariant.solid,
    AppChipVariant.soft,
    AppChipVariant.subtle,
    AppChipVariant.outline,
  ];

  static const List<AppChipSize> _sizes = <AppChipSize>[
    AppChipSize.large,
    AppChipSize.medium,
    AppChipSize.small,
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle sectionStyle = textTheme.geist14SemiBold.copyWith(
      color: AppColors.textSecondary,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Chip', style: textTheme.geist18SemiBold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final AppChipVariant variant in _variants) ...<Widget>[
              Text(variant.name, style: sectionStyle),
              SizedBox(height: 12.h),
              for (final AppChipSize size in _sizes) ...<Widget>[
                Wrap(
                  spacing: 16.w,
                  runSpacing: 12.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    for (final AppBadgeColor color in _colors)
                      AppChip(
                        label: 'Label',
                        color: color,
                        variant: variant,
                        size: size,
                      ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }
}
