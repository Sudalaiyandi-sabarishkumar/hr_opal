import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class BadgesChipsControlsPage extends StatefulWidget {
  const BadgesChipsControlsPage({super.key});

  @override
  State<BadgesChipsControlsPage> createState() =>
      _BadgesChipsControlsPageState();
}

class _BadgesChipsControlsPageState extends State<BadgesChipsControlsPage> {
  bool _toggleValue = true;
  bool? _checkboxValue = false;
  int _radioValue = 0;

  static const List<AppBadgeColor> _colors = <AppBadgeColor>[
    AppBadgeColor.info,
    AppBadgeColor.neutral,
    AppBadgeColor.success,
    AppBadgeColor.warning,
    AppBadgeColor.danger,
  ];

  static const List<AppBadgeVariant> _badgeVariants = <AppBadgeVariant>[
    AppBadgeVariant.solid,
    AppBadgeVariant.soft,
    AppBadgeVariant.subtle,
  ];

  static const List<AppChipVariant> _chipVariants = <AppChipVariant>[
    AppChipVariant.solid,
    AppChipVariant.soft,
    AppChipVariant.subtle,
    AppChipVariant.outline,
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle sectionStyle = textTheme.geist16SemiBold;
    final TextStyle subStyle = textTheme.geist14SemiBold.copyWith(
      color: AppColors.textSecondary,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Badges', style: sectionStyle),
          SizedBox(height: 12.h),
          for (final AppBadgeVariant variant in _badgeVariants) ...<Widget>[
            Text(variant.name, style: subStyle),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: <Widget>[
                for (final AppBadgeColor color in _colors)
                  AppBadge(label: 'Label', color: color, variant: variant),
              ],
            ),
            SizedBox(height: 16.h),
          ],
          SizedBox(height: 16.h),
          Text('Chips', style: sectionStyle),
          SizedBox(height: 12.h),
          for (final AppChipVariant variant in _chipVariants) ...<Widget>[
            Text(variant.name, style: subStyle),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: <Widget>[
                for (final AppBadgeColor color in _colors)
                  AppChip(label: 'Label', color: color, variant: variant),
              ],
            ),
            SizedBox(height: 16.h),
          ],
          SizedBox(height: 16.h),
          Text('Toggle', style: sectionStyle),
          SizedBox(height: 12.h),
          AppToggle(
            value: _toggleValue,
            onChanged: (bool v) => setState(() => _toggleValue = v),
          ),
          SizedBox(height: 32.h),
          Text('Checkbox', style: sectionStyle),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[
              AppCheckbox(
                value: _checkboxValue,
                onChanged: (bool? v) => setState(() => _checkboxValue = v),
              ),
              SizedBox(width: 16.w),
              AppRadio<int>(
                value: 0,
                groupValue: _radioValue,
                onChanged: (int v) => setState(() => _radioValue = v),
              ),
              SizedBox(width: 12.w),
              AppRadio<int>(
                value: 1,
                groupValue: _radioValue,
                onChanged: (int v) => setState(() => _radioValue = v),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Text('Avatar', style: sectionStyle),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[
              const AppAvatar(initials: 'AB', size: AppAvatarSize.small),
              SizedBox(width: 12.w),
              const AppAvatar(initials: 'CD'),
              SizedBox(width: 12.w),
              const AppAvatar(initials: 'EF', size: AppAvatarSize.large),
            ],
          ),
        ],
      ),
    );
  }
}
