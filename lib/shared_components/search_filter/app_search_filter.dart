import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class AppSearchFilterBar extends StatelessWidget {
  const AppSearchFilterBar({
    super.key,
    this.hintText = 'Search',
    this.onChanged,
    this.onFilterTap,
    this.controller,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  static const double _height = 46;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // Search field
        Expanded(
          child: Container(
            height: _height.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.neutral50,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 22.r,
                  color: AppColors.searchHint,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: textTheme.geist16Regular.copyWith(
                        color: AppColors.searchHint,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: textTheme.geist16Regular.copyWith(
                      color: AppColors.searchTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),

        // Filter button
        Material(
          color: AppColors.white,
          shape: const CircleBorder(
            side: BorderSide(color: AppColors.searchBorder, width: 1),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onFilterTap,
            child: SizedBox(
              width: _height.h,
              height: _height.h,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.profileBookOpen, // <- your filter/sliders svg
                  width: 20.w,
                  height: 20.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}