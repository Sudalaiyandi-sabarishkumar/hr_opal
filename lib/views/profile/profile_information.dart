import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/accordion/app_accordion.dart';

class ProfileInfoRowData {
  const ProfileInfoRowData({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileInfoSection {
  const ProfileInfoSection({
    required this.title,
    required this.icon,
    required this.headerColor,
    required this.iconColor,
    required this.rows,
    this.initiallyExpanded = false,
  });

  final String title;
  final IconData icon;
  final Color headerColor;
  final Color iconColor;
  final List<ProfileInfoRowData> rows;
  final bool initiallyExpanded;
}

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({
    super.key,
    this.name = 'Sarah Johnson',
    this.designation = 'Senior Software Engineer',
    this.sections = const <ProfileInfoSection>[
      ProfileInfoSection(
        title: 'Basic Information',
        icon: Icons.badge_outlined,
        headerColor: AppColors.accordionPurpleBg,
        iconColor: AppColors.accordionPurpleFg,
        initiallyExpanded: true,
        rows: <ProfileInfoRowData>[
          ProfileInfoRowData(label: 'Title', value: 'Mr.'),
          ProfileInfoRowData(label: 'First name', value: 'Michael'),
          ProfileInfoRowData(label: 'Middle name', value: 'James'),
          ProfileInfoRowData(label: 'Last name', value: 'Anderson'),
          ProfileInfoRowData(
            label: 'Passport name',
            value: 'Anderson Michael James',
          ),
          ProfileInfoRowData(label: 'Gender', value: 'Male'),
          ProfileInfoRowData(label: 'Date of birth', value: '03/15/1990'),
          ProfileInfoRowData(
            label: 'Place of birth',
            value: 'Portland, Oregon',
          ),
          ProfileInfoRowData(label: 'Marital status', value: 'Married'),
          ProfileInfoRowData(label: 'Blood group', value: 'O+'),
          ProfileInfoRowData(label: 'Nationality', value: 'American'),
          ProfileInfoRowData(label: 'Religion', value: 'Christian'),
        ],
      ),
      ProfileInfoSection(
        title: 'Contact Information',
        icon: Icons.mail_outline_rounded,
        headerColor: AppColors.accordionGreenBg,
        iconColor: AppColors.accordionGreenFg,
        rows: <ProfileInfoRowData>[
          ProfileInfoRowData(
            label: 'Email',
            value: 'sarah.johnson@example.com',
          ),
          ProfileInfoRowData(label: 'Phone', value: '+1 (555) 123-4567'),
        ],
      ),
      ProfileInfoSection(
        title: 'Employee details',
        icon: Icons.badge_outlined,
        headerColor: AppColors.accordionYellowBg,
        iconColor: AppColors.accordionYellowFg,
        rows: <ProfileInfoRowData>[
          ProfileInfoRowData(label: 'Employee ID', value: 'HRC0001'),
          ProfileInfoRowData(label: 'Department', value: 'Engineering'),
        ],
      ),
    ],
  });

  final String name;
  final String designation;
  final List<ProfileInfoSection> sections;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Personal Information',
      headerHeight: 260,
      titleBottomSpacing: 16,
      // The card below floats lower than the header, leaving the gradient
      // visible behind the avatar that overlaps its top edge — so the
      // body area itself stays transparent instead of painting white.
      bodyBackgroundColor: Colors.transparent,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            child: Container(
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
                    style: textThemeOf(context).geist18SemiBold
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    designation,
                    textAlign: TextAlign.center,
                    style: textThemeOf(context).geist13Regular
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        for (final ProfileInfoSection section
                            in sections) ...<Widget>[
                          AppAccordion(
                            title: section.title,
                            icon: section.icon,
                            headerColor: section.headerColor,
                            iconColor: section.iconColor,
                            initiallyExpanded: section.initiallyExpanded,
                            child: Column(
                              children: <Widget>[
                                for (final ProfileInfoRowData row
                                    in section.rows)
                                  AppInfoRow(
                                    label: row.label,
                                    value: row.value,
                                  ),
                              ],
                            ),
                          ),
                          if (section != sections.last) SizedBox(height: 12.h),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
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
                      border: Border.all(color: AppColors.white, width: 0),
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
                        border: Border.all(color: AppColors.neutral200),
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
    );
  }
}

TextTheme textThemeOf(BuildContext context) => Theme.of(context).textTheme;
