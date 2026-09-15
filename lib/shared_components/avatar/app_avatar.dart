import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageProvider,
    this.initials,
    this.size = AppAvatarSize.medium,
  });

  final ImageProvider? imageProvider;
  final String? initials;
  final AppAvatarSize size;

  double get _diameter => switch (size) {
    AppAvatarSize.small => 32.r,
    AppAvatarSize.medium => 48.r,
    AppAvatarSize.large => 64.r,
  };

  double get _fontSize => switch (size) {
    AppAvatarSize.small => 12,
    AppAvatarSize.medium => 16,
    AppAvatarSize.large => 20,
  };

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double diameter = _diameter;

    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.neutral100,
        image: imageProvider != null
            ? DecorationImage(image: imageProvider!, fit: BoxFit.cover)
            : null,
      ),
      child: imageProvider == null && initials != null && initials!.isNotEmpty
          ? Text(
              initials!,
              style: textTheme.geist14Medium.copyWith(
                fontSize: _fontSize.sp,
                color: AppColors.textSecondary,
              ),
            )
          : null,
    );
  }
}
