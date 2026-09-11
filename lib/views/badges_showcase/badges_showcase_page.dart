import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class BadgesShowcasePage extends StatelessWidget {
  const BadgesShowcasePage({super.key});

  static const List<AppBadgeColor> _colors = <AppBadgeColor>[
    AppBadgeColor.info,
    AppBadgeColor.neutral,
    AppBadgeColor.success,
    AppBadgeColor.warning,
    AppBadgeColor.danger,
  ];

  static const List<AppBadgeVariant> _variants = <AppBadgeVariant>[
    AppBadgeVariant.solid,
    AppBadgeVariant.soft,
    AppBadgeVariant.subtle,
  ];

  static const List<AppBadgeSize> _sizes = <AppBadgeSize>[
    AppBadgeSize.large,
    AppBadgeSize.medium,
    AppBadgeSize.small,
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
        title: Text('Badges', style: textTheme.geist18SemiBold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final AppBadgeVariant variant in _variants) ...<Widget>[
              Text(variant.name, style: sectionStyle),
              SizedBox(height: 12.h),
              for (final AppBadgeSize size in _sizes) ...<Widget>[
                Wrap(
                  spacing: 16.w,
                  runSpacing: 12.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    for (final AppBadgeColor color in _colors)
                      AppBadge(
                        label: 'Label',
                        color: color,
                        variant: variant,
                        size: size,
                        trailing: variant == AppBadgeVariant.solid &&
                                size != AppBadgeSize.small
                            ? AppBadgeTrailing.icon
                            : AppBadgeTrailing.none,
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
