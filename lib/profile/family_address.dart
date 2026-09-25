import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../shared_components/tabs/app_segmented_tabs.dart';

class FamilyMember {
  const FamilyMember({
    required this.relationType,
    required this.name,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.footerText,
  });

  final String relationType;
  final String name;
  final String dateOfBirth;
  final String phoneNumber;
  final String email;
  final String footerText;
}

class FamilyAddressPage extends StatefulWidget {
  const FamilyAddressPage({super.key});

  @override
  State<FamilyAddressPage> createState() => _FamilyAddressPageState();
}

class _FamilyAddressPageState extends State<FamilyAddressPage> {
  late final PageController _pageController;

  int _currentMemberIndex = 0;

  final List<FamilyMember> _members = const [
    FamilyMember(
      relationType: 'Spouse',
      name: 'Elizabeth Leanora Cunningham',
      dateOfBirth: '01 Sept 1990',
      phoneNumber: '(301) 580-7410',
      email: 'elizabeth_cunningham@gmail.com',
      footerText: 'Nominee',
    ),
    FamilyMember(
      relationType: 'Son',
      name: 'John Cunningham',
      dateOfBirth: '15 May 2015',
      phoneNumber: '(301) 580-7411',
      email: 'john_cunningham@gmail.com',
      footerText: 'Nominee',
    ),
    FamilyMember(
      relationType: 'Daughter',
      name: 'Emily Cunningham',
      dateOfBirth: '20 Oct 2018',
      phoneNumber: '(301) 580-7412',
      email: 'emily_cunningham@gmail.com',
      footerText: 'Nominee',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.82);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(title: 'Family & Address', textTheme: textTheme),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            pageBackground(),
            pageForeground(textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  Widget pageBackground() {
    return SvgPicture.asset(
      AppAssets.familyPageBg,
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
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 12.r,
              spreadRadius: 0.r,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 34.h),

            AppSegmentedTabs(
              labels: const <String>['Family Members', 'Address'],
              selectedIndex: 0,
              onChanged: (int index) {},
            ),

            SizedBox(height: 30.h),

            memberCarousel(textTheme: textTheme),

            const Spacer(),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: countComponent(
                key: ValueKey<int>(_currentMemberIndex),
                textTheme: textTheme,
                totalSteps: _members.length.toString(),
                currentStep: (_currentMemberIndex + 1).toString(),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget memberCarousel({required TextTheme textTheme}) {
    return SizedBox(
      height: 553.h,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _members.length,
        onPageChanged: (int index) {
          setState(() {
            _currentMemberIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          final FamilyMember member = _members[index];

          return AnimatedBuilder(
            animation: _pageController,
            builder: (BuildContext context, Widget? child) {
              double scale = 1.0;

              if (_pageController.position.hasContentDimensions) {
                final double page =
                    _pageController.page ?? _currentMemberIndex.toDouble();

                final double difference = (page - index).abs();

                scale = (1 - (difference * 0.04)).clamp(0.94, 1.0);
              }

              return Center(
                child: Transform.scale(scale: scale, child: child),
              );
            },
            child: memberDisplayCard(
              textTheme: textTheme,
              relationType: member.relationType,
              name: member.name,
              dateOfBirth: member.dateOfBirth,
              phoneNumber: member.phoneNumber,
              email: member.email,
              footerText: member.footerText,
            ),
          );
        },
      ),
    );
  }

  Widget memberDisplayCard({
    required TextTheme textTheme,
    required String relationType,
    required String name,
    required String dateOfBirth,
    required String phoneNumber,
    required String email,
    required String footerText,
  }) {
    return Container(
      width: 310.w,
      height: 553.h,
      padding: EdgeInsets.all(0.79.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.borderBlue, AppColors.transparent],
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 16.r,
            spreadRadius: -6.r,
            color: AppColors.darkBlueShadow.withValues(alpha: 0.08),
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17.2.r),
        child: ColoredBox(
          color: AppColors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  AppAssets.memberCardBg,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),

              Column(
                children: [
                  SizedBox(height: 45.h),

                  photoComponent(
                    textTheme: textTheme,
                    relationType: relationType,
                  ),

                  SizedBox(height: 30.h),

                  nameComponent(textTheme: textTheme, name: name),

                  SizedBox(height: 32.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: detailComponent(
                          textTheme: textTheme,
                          detailIcon: AppAssets.cakeIcon,
                          detailName: 'Birthday',
                          detailValue: dateOfBirth,
                        ),
                      ),

                      Container(
                        height: 34.h,
                        width: 1.w,
                        color: AppColors.statusSoftBg,
                      ),

                      Expanded(
                        child: detailComponent(
                          textTheme: textTheme,
                          detailIcon: AppAssets.phoneIcon,
                          detailName: 'Phone',
                          detailValue: phoneNumber,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  emailComponent(textTheme: textTheme, detailValue: email),

                  const Spacer(),

                  cardFooter(textTheme: textTheme, name: footerText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameComponent({required TextTheme textTheme, required String name}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.5.w),
      child: Text(
        name,
        style: textTheme.geist24Medium.copyWith(fontFamily: 'HostGrotesk'),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget detailComponent({
    required TextTheme textTheme,
    required String detailIcon,
    required String detailName,
    required String detailValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3.h,
        children: [
          Row(
            spacing: 4.w,
            children: [
              SvgPicture.asset(detailIcon),
              Text(
                detailName,
                style: textTheme.geist12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Text(
            detailValue,
            style: textTheme.geist14Regular.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailComponent({
    required TextTheme textTheme,
    required String detailValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.5.w),
      child: Column(
        spacing: 3.h,
        children: [
          Row(
            spacing: 4.w,
            children: [
              SvgPicture.asset(AppAssets.emailIcon),
              Text(
                'Email',
                style: textTheme.geist12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  detailValue,
                  style: textTheme.geist14Regular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AppAssets.copyIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardFooter({required TextTheme textTheme, required String name}) {
    return Container(
      height: 26.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardFooterGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: textTheme.geist12Regular.copyWith(
            fontSize: 13.sp,
            color: AppColors.cardFooterDarkGreen,
          ),
        ),
      ),
    );
  }

  Widget photoComponent({
    required TextTheme textTheme,
    required String relationType,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 235.h,
          width: 184.w,
          padding: EdgeInsets.all(3.75.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(108.77.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(105.r),
            child: Image.asset(
              AppAssets.dummyImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          bottom: -10,
          child: relationTag(textTheme: textTheme, relationType: relationType),
        ),
      ],
    );
  }

  Widget relationTag({
    required TextTheme textTheme,
    required String relationType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.62.r,
            spreadRadius: 0.r,
            color: AppColors.black.withValues(alpha: 0.08),
            offset: Offset(0.w, 3.75.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 4.h),
        child: Text(
          relationType,
          style: textTheme.geist12Regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Widget countComponent({
    Key? key,
    required TextTheme textTheme,
    required String totalSteps,
    required String currentStep,
  }) {
    return Text(
      key: key,
      '$currentStep of $totalSteps Family Members',
      style: textTheme.geist12Regular.copyWith(color: AppColors.textSecondary),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
    required this.title,
    required this.textTheme,
  });

  final String title;
  final TextTheme textTheme;

  @override
  Size get preferredSize => Size.fromHeight(39.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      elevation: 0,
      toolbarHeight: 64.h,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: 50.w,
      leading: backIcon(context: context),
      title: titleWidget(),
    );
  }

  Widget backIcon({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: InkWell(
        onTap: context.pop,
        child: Container(
          height: 34.r,
          width: 34.r,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 1.w, color: AppColors.backBorderColor),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            height: 12.h,
            width: 7.w,
            child: SvgPicture.asset(AppAssets.backIcon),
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: textTheme.geist20SemiBold.copyWith(
        color: AppColors.appBarTitleColor,
        fontFamily: 'HostGrotesk',
      ),
    );
  }
}
