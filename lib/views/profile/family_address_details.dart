import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/info_card/app_info_card.dart';
import '../../shared_components/tabs/app_segmented_tabs.dart';



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

class AddressDetail {
  const AddressDetail({
    required this.title,
    required this.headerColor,
    required this.addressLine,
    required this.contactName,
    required this.email,
    required this.phone,
  });

  final String title;
  final Color headerColor;
  final String addressLine;
  final String contactName;
  final String email;
  final String phone;
}

class FamilyAddressPage extends StatefulWidget {
  const FamilyAddressPage({super.key});

  @override
  State<FamilyAddressPage> createState() => _FamilyAddressPageState();
}

class _FamilyAddressPageState extends State<FamilyAddressPage> {
  late final PageController _pageController;

  int _currentMemberIndex = 0;
  int _segmentedIndex = 0;

  final List<String> _tabLabels = const <String>[
    'Family Members',
    'Address',
  ];

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

  final List<AddressDetail> _addresses = const <AddressDetail>[
    AddressDetail(
      title: 'Current Address',
      headerColor: AppColors.accordionPurpleBg,
      addressLine:
          '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
          'United States',
      contactName: 'Jonathan Doeverington',
      email: 'katie63@aol.com',
      phone: '(765) 322-1399',
    ),
    AddressDetail(
      title: 'Permanent Address',
      headerColor: AppColors.accordionGreenBg,
      addressLine:
          '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
          'United States',
      contactName: 'Jonathan Doeverington',
      email: 'katie63@aol.com',
      phone: '(765) 322-1399',
    ),
    AddressDetail(
      title: 'Emergency Address',
      headerColor: AppColors.accordionYellowBg,
      addressLine:
          '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
          'United States',
      contactName: 'Jonathan Doeverington',
      email: 'katie63@aol.com',
      phone: '(765) 322-1399',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.82,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'Family & Address',
      topSpacing: 59,
      body: pageForeground(textTheme: textTheme),
    );
  }

  Widget pageForeground({
    required TextTheme textTheme,
  }) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: [
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
              labels: _tabLabels,
              selectedIndex: _segmentedIndex,
              onChanged: (int index) {
                setState(() {
                  _segmentedIndex = index;
                });
              },
            ),

            SizedBox(height: 30.h),

            Expanded(
              child: _segmentedIndex == 0
                  ? memberTabContent(textTheme: textTheme)
                  : addressTabContent(textTheme: textTheme),
            ),
          ],
        ),
    );
  }

  Widget memberTabContent({
    required TextTheme textTheme,
  }) {
    return Column(
      children: [
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
    );
  }

  Widget addressTabContent({
    required TextTheme textTheme,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        24.h,
      ),
      child: _buildAddressContent(
        textTheme: textTheme,
        addresses: _addresses,
      ),
    );
  }

  Widget memberCarousel({
    required TextTheme textTheme,
  }) {
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
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          final FamilyMember member = _members[index];

          return AnimatedBuilder(
            animation: _pageController,
            builder: (
              BuildContext context,
              Widget? child,
            ) {
              double scale = 1.0;

              if (_pageController.position.hasContentDimensions) {
                final double page =
                    _pageController.page ??
                    _currentMemberIndex.toDouble();

                final double difference =
                    (page - index).abs();

                scale = (1 - (difference * 0.04))
                    .clamp(0.94, 1.0);
              }

              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
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
          colors: [
            AppColors.borderBlue,
            AppColors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 16.r,
            spreadRadius: -6.r,
            color: AppColors.darkBlueShadow.withValues(alpha: 0.08),
            offset: Offset(
              0.w,
              8.h,
            ),
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

                  nameComponent(
                    textTheme: textTheme,
                    name: name,
                  ),

                  SizedBox(height: 32.h),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: detailComponent(
                          textTheme: textTheme,
                          detailIcon: AppAssets.profileCake,
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
                          detailIcon: AppAssets.profileRing,
                          detailName: 'Phone',
                          detailValue: phoneNumber,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  emailComponent(
                    textTheme: textTheme,
                    detailValue: email,
                  ),

                  const Spacer(),

                  cardFooter(
                    textTheme: textTheme,
                    name: footerText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameComponent({
    required TextTheme textTheme,
    required String name,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 22.5.w,
      ),
      child: Text(
        name,
        style: textTheme.geist24Medium.copyWith(
          fontFamily: 'HostGrotesk',
        ),
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
      padding: EdgeInsets.symmetric(
        horizontal: 22.5.w,
      ),
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
      padding: EdgeInsets.symmetric(
        horizontal: 22.5.w,
      ),
      child: Column(
        spacing: 3.h,
        children: [
          Row(
            spacing: 4.w,
            children: [
              SvgPicture.asset(
                AppAssets.profileMail,
              ),
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
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
                child: SvgPicture.asset(
                  AppAssets.profileCopy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardFooter({
    required TextTheme textTheme,
    required String name,
  }) {
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
            borderRadius: BorderRadius.circular(
              108.77.r,
            ),
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
          child: relationTag(
            textTheme: textTheme,
            relationType: relationType,
          ),
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
            offset: Offset(
              0.w,
              3.75.h,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 11.w,
          vertical: 4.h,
        ),
        child: Text(
          relationType,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.white,
          ),
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
      style: textTheme.geist12Regular.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildAddressContent({
    required TextTheme textTheme,
    required List<AddressDetail> addresses,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < addresses.length; i++) ...[
          if (i != 0) SizedBox(height: 15.h),
          _AddressCard(
            address: addresses[i],
            textTheme: textTheme,
          ),
        ],
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.textTheme,
  });

  final AddressDetail address;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      title: address.title,
      headerColor: address.headerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.addressLine,
            style: textTheme.geist14Regular.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 16.h),

          AppStackedInfoRow(
            label: 'Contact details',
            value: address.contactName,
          ),

          SizedBox(height: 16.h),

          AppStackedInfoRow(
            label: 'Email',
            value: address.email,
          ),

          SizedBox(height: 16.h),

          AppStackedInfoRow(
            label: 'Phone',
            value: address.phone,
            icon: AppAssets.profileRing,
          ),
        ],
      ),
    );
  }
}
