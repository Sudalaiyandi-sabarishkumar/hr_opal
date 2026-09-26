import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: const PageAppBar(),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            pageBackground(),
            pageForeground(textTheme: textTheme, context: context),
          ],
        ),
      ),
    );
  }

  Widget pageBackground() {
    return Image.asset(
      AppAssets.bg4Image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget pageForeground({
    required TextTheme textTheme,
    required BuildContext context,
  }) {
    return Positioned(
      top: 65.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          headerComponent(
            textTheme: textTheme,
            employeeId: 'HROP001',
            profilePhoto: AppAssets.dummyImage4,
            status: 'Clocked In',
          ),
          SizedBox(height: 14.h),
          nameAndRole(
            textTheme: textTheme,
            name: 'Sarah Johnson',
            role: 'Senior Software Engineer',
          ),
          SizedBox(height: 26.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _SectionLabel(
                      label: 'PROFILE DETAILS',
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 8.h),
                    AppOptionCard(tiles: _profileDetailTiles(context)),
                    SizedBox(height: 16.h),
                    const _SectionLabel(label: 'SETTINGS'),
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
            ),
          ),
        ],
      ),
    );
  }

  List<AppOptionTile> _profileDetailTiles(BuildContext context) {
    return <AppOptionTile>[
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
        onTap: () {
          context.push(RouteConstants.familyAddressPage);
        },
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
        onTap: () {
          context.push(RouteConstants.myteamPage);
        },
      ),
      AppOptionTile(
        svgAsset: AppAssets.profileBookOpen,
        label: 'Qualification and Skills',
        onTap: () {
          context.push(RouteConstants.qualificationsPage);
        },
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
        onTap: () {
          context.push(RouteConstants.timeleinePage);
        },
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
  }

  List<AppOptionTile> get _settingsTiles {
    return <AppOptionTile>[
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
  }

  Widget headerComponent({
    required TextTheme textTheme,
    required String employeeId,
    required String profilePhoto,
    required String status,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        employeeIdDisplayText(textTheme: textTheme, employeeId: employeeId),
        profileIconWithStatus(
          textTheme: textTheme,
          profilePhoto: profilePhoto,
          status: status,
        ),
        Positioned(
          bottom: -10,
          child: statusTag(textTheme: textTheme, status: status),
        ),
      ],
    );
  }

  Widget nameAndRole({
    required TextTheme textTheme,
    required String name,
    required String role,
  }) {
    return Column(
      spacing: 2.h,
      children: [
        Text(
          name,
          style: textTheme.geist20SemiBold.copyWith(
            color: AppColors.appBarTitleColor,
            fontFamily: 'HostGrotesk',
          ),
        ),
        Text(
          role,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.toastMessage,
          ),
        ),
      ],
    );
  }

  Widget statusTag({required TextTheme textTheme, required String status}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.r,
            spreadRadius: -6.r,
            color: AppColors.darkBlueShadow.withValues(alpha: 0.12),
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: Text(
        status,
        style: textTheme.geist10Medium.copyWith(
          color: AppColors.toastSuccess,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget profileIconWithStatus({
    required TextTheme textTheme,
    required String profilePhoto,
    required String status,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 98.r,
          width: 98.r,
          decoration: BoxDecoration(
            color: AppColors.dark4blue,
            shape: BoxShape.circle,
            border: Border.all(width: 1.w, color: AppColors.white),
            boxShadow: [
              BoxShadow(
                blurRadius: 24.r,
                spreadRadius: -4.r,
                color: AppColors.darkBlueShadow.withValues(alpha: 0.08),
                offset: Offset(0.w, 8.h),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              profilePhoto,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget employeeIdDisplayText({
    required TextTheme textTheme,
    required String employeeId,
  }) {
    return Opacity(
      opacity: 0.4,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkblue,
              AppColors.dark2blue.withValues(alpha: 0.0),
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: Text(
          employeeId,
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
          style: textTheme.geist40Bold.copyWith(
            letterSpacing: 4,
            fontSize: 56.sp,
            fontFamily: 'HostGrotesk',
          ),
        ),
      ),
    );
  }
}

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(24.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64.h,
      automaticallyImplyLeading: false,
      leadingWidth: 50.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: GestureDetector(
          onTap: context.pop,
          child: SizedBox(
            height: 24.r,
            width: 24.r,
            child: Center(child: SvgPicture.asset(AppAssets.backIcon)),
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
          children: [
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
