import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../shared_components/shared_components.dart';

/// Employee profile screen: header with photo, name, designation,
/// HRC0001 watermark behind profile image, and clock-in status,
/// followed by grouped "Profile Details" and "Settings" transparent option lists,
/// and a logout action.
class FamilyAddress extends StatelessWidget {
  const FamilyAddress({
    super.key,
    this.employeeId = 'HRC0001',
    this.name = 'Sarah Johnson',
    this.designation = 'Senior Software Engineer',
    this.isClockedIn = true,
  });

  final String employeeId;
  final String name;
  final String designation;
  final bool isClockedIn;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          // Background bg4 image spanning 80% of screen height
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.8,
            child: Image.asset(
              AppAssets.bg4Image,
              width: screenWidth,
              height: screenHeight * 0.8,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          // Remaining 20% of screen height as solid white
          Positioned(
            top: screenHeight * 0.8,
            left: 0,
            right: 0,
            bottom: 0,
            child: const ColoredBox(
              color: AppColors.white,
            ),
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _Header(
                    employeeId: employeeId,
                    name: name,
                    designation: designation,
                    isClockedIn: isClockedIn,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AppOptionCard(
                      tiles: <AppOptionTile>[
                        AppOptionTile(
                          icon: Icons.person_outline_rounded,
                          label: 'Personal Information',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.people_alt_outlined,
                          label: 'Family and Address',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.work_outline_rounded,
                          label: 'Job Details',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.account_tree_outlined,
                          label: 'My Team',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.menu_book_outlined,
                          label: 'Qualification and Skills',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.badge_outlined,
                          label: 'My Documents',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.laptop_mac_outlined,
                          label: 'Assets',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.timeline_outlined,
                          label: 'Employee Timeline',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.receipt_long_outlined,
                          label: 'Transaction History',
                          onTap: () {},
                        ),
                        AppOptionTile(
                          icon: Icons.person_2_outlined,
                          label: 'Amendments',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: const _SectionLabel(label: 'SETTINGS'),
                        ),
                        SizedBox(height: 8.h),
                        AppOptionCard(
                          tiles: <AppOptionTile>[
                            AppOptionTile(
                              icon: Icons.notifications_none_rounded,
                              label: 'Notification Preferences',
                              onTap: () {},
                            ),
                            AppOptionTile(
                              icon: Icons.lock_outline_rounded,
                              label: 'Change Password',
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: _LogoutRow(onTap: () {}),
                        ),
                        SizedBox(height: 32.h),
                      ],
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

typedef ProfilePage = FamilyAddress;

class _Header extends StatelessWidget {
  const _Header({
    required this.employeeId,
    required this.name,
    required this.designation,
    required this.isClockedIn,
  });

  final String employeeId;
  final String name;
  final String designation;
  final bool isClockedIn;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 16.h),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              icon: Icon(
                Icons.chevron_left_rounded,
                color: AppColors.white,
                size: 26.r,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Avatar Stack with employeeId (HRC0001) behind the profile image
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
              // Watermark employee ID behind profile image
              IgnorePointer(
                child: Text(
                  employeeId,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: false,
                  style: textTheme.geist40Bold.copyWith(
                    color: AppColors.watermarkOnGradient,
                    letterSpacing: 4,
                    fontSize: 56.sp,
                  ),
                ),
              ),
              // Profile circular image
              Container(
                width: 98.r,
                height: 98.r,
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.femaleImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              // Clocked In status badge
              if (isClockedIn)
                Positioned(
                  bottom: -12.h,
                  child: const _ClockedInBadge(),
                ),
            ],
          ),
          SizedBox(height: 22.h),
          Text(
            name,
            style: textTheme.geist20SemiBold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            designation,
            style: textTheme.geist13Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: const _SectionLabel(
                label: 'PROFILE DETAILS',
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClockedInBadge extends StatelessWidget {
  const _ClockedInBadge();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        child: Text(
          'Clocked In',
          style: textTheme.geist12SemiBold.copyWith(
            color: AppColors.statusSuccess,
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      label,
      style: textTheme.geist14Medium.copyWith(
        color: color ?? AppColors.neutral500,
        fontSize: 11.sp,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _LogoutRow extends StatelessWidget {
  const _LogoutRow({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.logout_rounded,
              size: 18.r,
              color: AppColors.statusDanger,
            ),
            SizedBox(width: 8.w),
            Text(
              'Logout',
              style: textTheme.geist14Regular.copyWith(
                color: AppColors.statusDanger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
