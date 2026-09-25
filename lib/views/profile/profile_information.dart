import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/accordion/app_accordion.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({
    super.key,
    this.name = 'Sarah Johnson',
    this.designation = 'Senior Software Engineer',
  });

  final String name;
  final String designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 260.h,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.06, -1.0),
                        end: Alignment(0.06, 1.0),
                        colors: <Color>[
                          AppColors.white,
                          AppColors.headerGradientPeach,
                          AppColors.headerGradientPeach,
                        ],
                        stops: <double>[0.1186, 0.2587, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(-0.32, -1.5),
                        radius: 0.9,
                        colors: <Color>[
                          AppColors.headerRadialPurple,
                          AppColors.headerRadialPurpleTransparent,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 39.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: Text(
                        'Personal Information',
                        style: textThemeOf(context).geist18SemiBold.copyWith(
                              color: AppColors.textPrimary,
                              fontFamily: hostGroteskFont,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 64.h),
                        padding: EdgeInsets.fromLTRB(16.w, 46.h, 16.w, 24.h),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              name,
                              textAlign: TextAlign.center,
                              style: textThemeOf(context)
                                  .geist18SemiBold
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              designation,
                              textAlign: TextAlign.center,
                              style: textThemeOf(context)
                                  .geist13Regular
                                  .copyWith(color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 24.h),
                            const AppAccordion(
                              title: 'Basic Information',
                              icon: Icons.badge_outlined,
                              headerColor: AppColors.accordionPurpleBg,
                              iconColor: AppColors.accordionPurpleFg,
                              initiallyExpanded: true,
                              child: Column(
                                children: <Widget>[
                                  AppInfoRow(label: 'Title', value: 'Mr.'),
                                  AppInfoRow(
                                    label: 'First name',
                                    value: 'Michael',
                                  ),
                                  AppInfoRow(
                                  label: 'Middle name',
                                    value: 'James',
                                  ),
                                  AppInfoRow(
                                    label: 'Last name',
                                    value: 'Anderson',
                                  ),
                                  AppInfoRow(
                                    label: 'Passport name',
                                    value: 'Anderson Michael James',
                                  ),
                                  AppInfoRow(
                                    label: 'Passport name',
                                    value: 'Anderson Michael James',
                                  ),
                                  AppInfoRow(label: 'Gender', value: 'Male'),
                                  AppInfoRow(
                                    label: 'Date of birth',
                                    value: '03/15/1990',
                                  ),
                                  AppInfoRow(
                                    label: 'Place of birth',
                                    value: 'Portland, Oregon',
                                  ),
                                  AppInfoRow(
                                    label: 'Marital status',
                                    value: 'Married',
                                  ),
                                  AppInfoRow(
                                    label: 'Blood group',
                                    value: 'O+',
                                  ),
                                  AppInfoRow(
                                    label: 'Nationality',
                                    value: 'American',
                                  ),
                                  AppInfoRow(
                                    label: 'Religion',
                                    value: 'Christian',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            const AppAccordion(
                              title: 'Contact Information',
                              icon: Icons.mail_outline_rounded,
                              headerColor: AppColors.accordionGreenBg,
                              iconColor: AppColors.accordionGreenFg,
                              child: Column(
                                children: <Widget>[
                                  AppInfoRow(
                                    label: 'Email',
                                    value: 'sarah.johnson@example.com',
                                  ),
                                  AppInfoRow(
                                    label: 'Phone',
                                    value: '+1 (555) 123-4567',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            const AppAccordion(
                              title: 'Employee details',
                              icon: Icons.badge_outlined,
                              headerColor: AppColors.accordionYellowBg,
                              iconColor: AppColors.accordionYellowFg,
                              child: Column(
                                children: <Widget>[
                                  AppInfoRow(
                                    label: 'Employee ID',
                                    value: 'HRC0001',
                                  ),
                                  AppInfoRow(
                                    label: 'Department',
                                    value: 'Engineering',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Container(
                                width: 90.w,
                                height: 90.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.dark4blue,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 0,
                                  ),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 16,
                                      offset: Offset(0, 8),
                                      spreadRadius: 2,
                                      color: AppColors.avatarShadow,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    AppAssets.femaleImage,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -2.w,
                                bottom: 2.h,
                                child: Container(
                                  width: 30.r,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.neutral200,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 15.r,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
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

TextTheme textThemeOf(BuildContext context) => Theme.of(context).textTheme;
