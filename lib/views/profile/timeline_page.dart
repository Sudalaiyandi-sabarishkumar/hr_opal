import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import 'family_address_details.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(
        title: 'Timeline',
        textTheme: textTheme,
        showTitle: false,
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            pageBackground(),
            pageForeground(textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  Widget pageBackground() {
    return Image.asset(
      AppAssets.timelinePageBg,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget pageForeground({required TextTheme textTheme}) {
    return Positioned(
      top: 101.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          pageTitle(textTheme: textTheme, name: 'Sarah Johnson'),
          SizedBox(height: 12.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.h),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.purple,
                    timelineType: TimelineType.anniversary,
                    timelineName: '7th Work Anniversary',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.green,
                    timelineType: TimelineType.award,
                    timelineName: 'Star Employee Award',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                    isReverse: true,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.orange,
                    timelineType: TimelineType.anniversary,
                    timelineName: '8th Work Anniversary',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.purple,
                    timelineType: TimelineType.award,
                    timelineName: 'Star Employee Award',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                    isReverse: true,
                    reverseSeparator: true,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.green,
                    timelineType: TimelineType.anniversary,
                    timelineName: '9th Work Anniversary',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                    reverseSeparator: true,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.orange,
                    timelineType: TimelineType.award,
                    timelineName: 'Star Employee Award',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                    isReverse: true,
                    reverseSeparator: true,
                  ),
                  timelineWithSeparator(
                    textTheme: textTheme,
                    colorBase: TimelineColorBase.purple,
                    timelineType: TimelineType.anniversary,
                    timelineName: '10th Work Anniversary',
                    timelineDate: '18 Jun 2026',
                    frontPhoto: AppAssets.dummyImage2,
                    backPhoto: AppAssets.dummyImage3,
                    isLastTimeleine: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageTitle({required TextTheme textTheme, required String name}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$name's",
          textAlign: TextAlign.center,
          style: textTheme.geist32SemiBold.copyWith(
            fontFamily: 'HostGrotesk',
            color: AppColors.white,
          ),
        ),
        Transform.translate(
          offset: Offset(0, -8.h),
          child: Text(
            'Timeline',
            textAlign: TextAlign.center,
            style: textTheme.geist20Bold.copyWith(
              fontFamily: 'HostGrotesk',
              color: AppColors.tagColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget timelineWithSeparator({
    required TextTheme textTheme,
    required TimelineColorBase colorBase,
    required TimelineType timelineType,
    required String timelineName,
    required String timelineDate,
    required String frontPhoto,
    required String backPhoto,
    bool isReverse = false,
    bool reverseSeparator = false,
    bool isLastTimeleine = false,
  }) {
    return Column(
      children: [
        timelineRow(
          textTheme: textTheme,
          colorBase: colorBase,
          timelineType: timelineType,
          timelineName: timelineName,
          timelineDate: timelineDate,
          frontPhoto: frontPhoto,
          backPhoto: backPhoto,
          isReverse: isReverse,
        ),
        SizedBox(height: 10.h),
        if (!isLastTimeleine)
          Transform.flip(
            flipY: reverseSeparator,
            child: SvgPicture.asset(
              getTimelineSeparator(colorBase),
              height: 69.h,
              width: 151.w,
            ),
          ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget timelineRow({
    required TextTheme textTheme,
    required TimelineColorBase colorBase,
    required TimelineType timelineType,
    required String timelineName,
    required String timelineDate,
    required String frontPhoto,
    required String backPhoto,
    bool isReverse = false,
  }) {
    final Widget details = timelineDetailsComponent(
      textTheme: textTheme,
      colorBase: colorBase,
      timelineType: timelineType,
      timelineName: timelineName,
      timelineDate: timelineDate,
    );

    final Widget photos = timelinePhotoComponent(
      frontPhoto: frontPhoto,
      backPhoto: backPhoto,
      isLeft: isReverse,
    );

    return Padding(
      padding: isReverse
          ? EdgeInsets.only(left: 60.w)
          : EdgeInsets.only(right: 60.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.w,
        children: isReverse ? [photos, details] : [details, photos],
      ),
    );
  }

  Widget timelineDetailsComponent({
    required TextTheme textTheme,
    required TimelineColorBase colorBase,
    required TimelineType timelineType,
    required String timelineName,
    required String timelineDate,
  }) {
    return SizedBox(
      width: 146.w,
      child: Column(
        children: [
          Container(
            height: 51.r,
            width: 51.r,
            decoration: BoxDecoration(
              color: getComponentColor(colorBase),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Center(
              child: SizedBox(
                height: 20.r,
                width: 20.r,
                child: SvgPicture.asset(getComponentIcon(timelineType)),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            timelineName,
            textAlign: TextAlign.center,
            softWrap: true,
            style: textTheme.geist14Medium.copyWith(
              color: AppColors.textPrimary,
              fontFamily: 'HostGrotesk',
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            timelineDate,
            textAlign: TextAlign.center,
            style: textTheme.geist12Regular.copyWith(
              color: AppColors.toastMessage,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget timelinePhotoComponent({
    required String frontPhoto,
    required String backPhoto,
    bool isLeft = false,
  }) {
    return SizedBox(
      height: 76.r,
      width: 76.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: isLeft ? 0 : 15.r,
            left: isLeft ? null : 75.r,
            right: isLeft ? 70.r : null,
            child: Transform.rotate(
              angle: 10.47 * math.pi / 180,
              child: Container(
                height: 58.r,
                width: 58.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.91.r),
                  border: Border.all(width: 1.14.w, color: AppColors.white),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 14.76.r,
                      spreadRadius: 0.r,
                      color: AppColors.darkBlueShadow.withValues(alpha: 0.12),
                      offset: Offset(0.w, 4.22.h),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.91.r),
                  child: Image.asset(
                    backPhoto,
                    width: 58.r,
                    height: 58.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: -12.78 * math.pi / 180,
            child: Container(
              height: 76.r,
              width: 76.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.36.r),
                border: Border.all(width: 1.5.w, color: AppColors.white),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 19.35.r,
                    spreadRadius: 0.r,
                    color: AppColors.darkBlueShadow.withValues(alpha: 0.12),
                    offset: Offset(0.w, 5.53.h),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.86.r),
                child: Image.asset(
                  frontPhoto,
                  width: 76.r,
                  height: 76.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTimelineSeparator(TimelineColorBase colorBase) {
    switch (colorBase) {
      case TimelineColorBase.purple:
        return AppAssets.purpleTimelineSeparator;
      case TimelineColorBase.green:
        return AppAssets.greenTimelineSeparator;
      case TimelineColorBase.orange:
        return AppAssets.orangeTimelineSeparator;
    }
  }

  Color getComponentColor(TimelineColorBase colorBase) {
    switch (colorBase) {
      case TimelineColorBase.purple:
        return AppColors.secondary500;
      case TimelineColorBase.green:
        return AppColors.statusSuccess;
      case TimelineColorBase.orange:
        return AppColors.statusWarning;
    }
  }

  String getComponentIcon(TimelineType timelineType) {
    switch (timelineType) {
      case TimelineType.anniversary:
        return AppAssets.emojiIcon;
      case TimelineType.award:
        return AppAssets.awardIcon;
    }
  }
}
