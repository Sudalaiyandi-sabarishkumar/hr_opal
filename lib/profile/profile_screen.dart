import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';
import '../core/theme/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../shared_components/shared_components.dart';

/// Employee profile screen: header with photo, name, designation,
/// HRC0001 watermark behind profile image, and clock-in status,
/// followed by grouped "Profile Details" and "Settings" transparent option lists,
/// and a logout action.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
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

  // Profile Details tiles — method (not getter) since it needs `context`
  // for navigation. Called from build() where context is available.
  List<AppOptionTile> _profileDetailTiles(BuildContext context) => <AppOptionTile>[
        AppOptionTile(
          svgAsset: AppAssets.profileUserSharing,
          label: 'Personal Information',
          onTap: () {context.push(RouteConstants.personalInformationPage);},
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileUserGroup,
          label: 'Family and Address',
          onTap: () => context.push(RouteConstants.familyAddressPage),
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileBriefcase,
          label: 'Job Details',
          onTap: () {},
        ),
        AppOptionTile(
         svgAsset: AppAssets.profileFlow,
          label: 'My Team',
          onTap: () => context.push(RouteConstants.myteamPage),
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileBookOpen,
          label: 'Qualification and Skills',
          onTap: () {},
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileFile,
          label: 'My Documents',
          onTap: () {},
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileComputerPhone,
          label: 'Assets',
          onTap: () {},
        ),
        AppOptionTile(
   svgAsset: AppAssets.profileWorkflowCircle,
          label: 'Employee Timeline',
          onTap: () {},
        ),
        AppOptionTile(
        svgAsset: AppAssets.profileWorkHistory,
          label: 'Transaction History',
          onTap: () {},
        ),
        AppOptionTile(
         svgAsset: AppAssets.profileUser,
          label: 'Amendments',
          onTap: () {},
        ),
      ];

  // Settings tiles — plain getter is fine since none of these navigate.
  List<AppOptionTile> get _settingsTiles => <AppOptionTile>[
        AppOptionTile(
         svgAsset: AppAssets.profileNotification,
          label: 'Notification Preferences',
          onTap: () {},
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileLock,
          label: 'Change Password',
          onTap: () {},
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          // Background bg4 image spanning the top of the screen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(AppAssets.bg4Image, fit: BoxFit.cover),
          ),

          // Scrollable content
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
                    child: AppOptionCard(tiles: _profileDetailTiles(context)),
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
                        AppOptionCard(tiles: _settingsTiles),
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

          // Fixed back button — sits above the scroll view as a Stack
          // sibling, so it never moves when the content scrolls.
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, top: 4.h),
              child: IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.white,
                  size: 26.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef ProfilePage = ProfileScreen;

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
      // Top padding bumped up since the back button used to live here
      // and reserved this space itself — adjust if it now sits too close
      // to the fixed back button floating above.
      padding: EdgeInsets.fromLTRB(8.w, 48.h, 8.w, 16.h),
      child: Column(
        children: <Widget>[
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
                  border: Border.all(
                    color: AppColors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: AppColors.dark4blue,
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
            SvgPicture.asset(
              AppAssets.profileLogout,
              width: 18.r,
              height: 18.r,
              colorFilter: const ColorFilter.mode(
                AppColors.statusDanger,
                BlendMode.srcIn,
              ),
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