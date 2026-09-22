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

  static const double _canvasWidth = 375;
  static const double _canvasHeight = 480;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFF7BA7D0),
      body: Background(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 59.h),
              Center(
                child: Image.asset(
                  AppAssets.hrOpalLogo,
                  height: 25.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 107.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'Your Workday\nSimplified',
                  textAlign: TextAlign.center,
                  style: textTheme.geist36Regular.copyWith(
                    color: AppColors.white,
                    height: 1.15,
                    letterSpacing: -0.5,
                    fontFamily: hostGroteskFont,
                  ),
                ),
              ),

              SizedBox(height: 61.h),

              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _canvasWidth / _canvasHeight,
                    child: FittedBox(
                      child: SizedBox(
                        width: _canvasWidth,
                        height: _canvasHeight,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              top: 33.h,
                             left: 265.w,
                              child: _FloatingCard(
                                child: SvgPicture.asset(
                                  AppAssets.card2,
                                  width: 154.w,
                                  height: 60.h,
                                ),
                              ),
                            ),

                            Positioned(
                              top: 146.h,
                              left: 10.w,
                              child: _FloatingCard(
                                child: SvgPicture.asset(
                                  AppAssets.card1,
                                  width: 150.w,
                                  height: 71.h,
                                ),
                              ),
                            ),

                            Positioned(
                              top: -75.h,
                              left: -20.w,
                              child: SvgPicture.asset(
                                AppAssets.dottedLine,
                                width: 190.w,
                              ),
                            ),

                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                AppAssets.femaleImage,
                                width: _canvasWidth,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _FloatingCard extends StatelessWidget {
  const _FloatingCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.10),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: child,
      ),
    );
  }
}
