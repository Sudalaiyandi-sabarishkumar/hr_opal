import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../shared_components/accordion/app_accordion.dart';


class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180.h,
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
                          Color(0xFF918CF6),
                          Color(0x00918CF6),
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
                        'Job Details',
                        style: textTheme.geist18SemiBold.copyWith(
                          color: AppColors.textPrimary,
                          fontFamily: hostGroteskFont,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height - 130.h,
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
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
                        const AppAccordion(
                          title: 'Job Details',
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
                              AppInfoRow(label: 'Blood group', value: 'O+'),
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
                      ],
                    ),
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
