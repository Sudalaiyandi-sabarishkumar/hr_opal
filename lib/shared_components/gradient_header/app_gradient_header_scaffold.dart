import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';

class AppGradientHeaderScaffold extends StatelessWidget {
  const AppGradientHeaderScaffold({
    super.key,
    required this.title,
    required this.body,
    this.headerBottom,
    this.gradient = AppHeaderGradient.peach,
    this.headerHeight = 180,
    this.titleColor,
    this.titleStyle,
    this.onBack,
    this.scaffoldBackgroundColor = AppColors.white,
    this.bodyBackgroundColor = AppColors.white,
    this.bodyBorderRadius = 24,
    this.topSpacing = 39,
    this.titleBottomSpacing = 20,
  });

  final String title;

  final Widget body;

  final Widget? headerBottom;

  final AppHeaderGradient gradient;

  final double headerHeight;

  final Color? titleColor;

  final TextStyle? titleStyle;

  final VoidCallback? onBack;

  final Color scaffoldBackgroundColor;

  final Color bodyBackgroundColor;

  final double bodyBorderRadius;

  final double topSpacing;

  final double titleBottomSpacing;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(AppAssets.bg5Image, fit: BoxFit.cover),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: topSpacing.h + 22.h + titleBottomSpacing.h,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 56.w),
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style:
                                titleStyle ??
                                textTheme.geist18SemiBold.copyWith(
                                  color: titleColor ?? AppColors.textPrimary,
                                  fontFamily: hostGroteskFont,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: InkWell(
                            onTap:
                                onBack ??
                                () {
                                  if (context.canPop()) {
                                    context.pop();
                                  }
                                },
                            borderRadius: BorderRadius.circular(22.r),
                            child: SizedBox(
                              width: 44.r,
                              height: 44.r,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.profileBackArrow,
                                  width: 34.r,
                                  height: 34.r,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (headerBottom != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    child: headerBottom,
                  ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: bodyBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(bodyBorderRadius.r),
                        topRight: Radius.circular(bodyBorderRadius.r),
                      ),
                    ),
                    child: body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
