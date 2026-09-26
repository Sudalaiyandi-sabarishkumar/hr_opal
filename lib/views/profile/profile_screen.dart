import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

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

  List<AppOptionTile> _profileDetailTiles(BuildContext context) =>
      <AppOptionTile>[
        AppOptionTile(
          svgAsset: AppAssets.profileUserSharing,
          label: 'Personal Information',
          onTap: () {
            context.push(RouteConstants.personalInformationPage);
          },
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileUserGroup,
          label: 'Family and Address',
          onTap: () => context.push(RouteConstants.familyAddressPage),
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileBriefcase,
          label: 'Job Details',
          onTap: () {
            context.push(RouteConstants.jobDetailsPage);
          },
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileFlow,
          label: 'My Team',
          onTap: () => context.push(RouteConstants.myteamPage),
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileBookOpen,
          label: 'Qualification and Skills',
          onTap: () => context.push(RouteConstants.qualificationsPage),
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileFile,
          label: 'My Documents',
          onTap: () {
            context.push(RouteConstants.documentsPage);
          },
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileComputerPhone,
          label: 'Assets',
          onTap: () {
            context.push(RouteConstants.assetsPage);
          },
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileWorkflowCircle,
          label: 'Employee Timeline',
          onTap: () {},
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileWorkHistory,
          label: 'Transaction History',
          onTap: () {
            context.push(RouteConstants.requestHistoryPage);
          },
        ),
        AppOptionTile(
          svgAsset: AppAssets.profileUser,
          label: 'Amendments',
          onTap: () {
            context.push(RouteConstants.amendmentsPage);
          },
        ),
      ];

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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(AppAssets.bg4Image, fit: BoxFit.cover),
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

          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, top: 4.h),
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
      padding: EdgeInsets.fromLTRB(8.w, 48.h, 8.w, 16.h),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
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

              Container(
                width: 98.r,
                height: 98.r,
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white, width: 0.75.w),
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

              if (isClockedIn)
                Positioned(bottom: -12.h, child: const _ClockedInBadge()),
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
        borderRadius: BorderRadius.circular(7.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Text(
          'Clocked In',
          style: textTheme.geist12Medium.copyWith(
            fontSize: 11.sp,
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
