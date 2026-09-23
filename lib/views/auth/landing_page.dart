import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../global_widgets/background.dart';
import '../../shared_components/button/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Background(
          child: Column(
            children: <Widget>[
              SizedBox(height: 59.h),
              logoImage(),
              SizedBox(height: 107.h),
              textComponent(textTheme),
              SizedBox(height: 61.h),
              imageComponent(),
              SizedBox(height: 84.h),
            ],
          ),
        ),
        floatingActionButton: buttonComponent(textTheme, context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget logoImage() {
    return Center(
      child: Image.asset(AppAssets.hrOpalLogo, height: 25.h, width: 87.w),
    );
  }

  Widget textComponent(TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Text(
        'Your Workday\nSimplified',
        textAlign: TextAlign.center,
        style: textTheme.geist36Regular.copyWith(
          color: AppColors.white,
          fontSize: 37.sp,
          height: 1.15,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget imageComponent() {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(top: -60, child: SvgPicture.asset(AppAssets.dottedLine)),
          Padding(
            padding: EdgeInsets.only(top: 145.h, left: 10.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                AppAssets.card1,
                height: 71.h,
                width: 150.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                AppAssets.card2,
                height: 60.h,
                width: 153.w,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              AppAssets.femaleImage,
              height: 520.h,
              width: 420.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonComponent(TextTheme textTheme, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 20.h),
      child: CustomButton(
        textStyle: textTheme.geist14Regular,
        buttonName: 'Get Started',
        icon: AppAssets.rightArrowIcon,
        isReverse: true,
        iconSize: 10.r,
        size: AppButtonSize.large,
        variant: AppButtonVariant.secondary,
        borderRadius: 60.r,
        height: 56.h,
        onTap: () => context.goNamed(RouteConstants.signInPage),
      ),
    );
  }
}
 