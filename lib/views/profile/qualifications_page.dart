import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import 'family_address_details.dart';

class QualificationsPage extends StatelessWidget {
  const QualificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(
        title: 'Qualifications & Skills',
        textTheme: textTheme,
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 28.w).copyWith(top: 16.h),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
          child: Column(
            children: [
              _QualificationCard(
                cardType: QualificationAndSkillsType.education,
                bodyBuilder: (isCollapsed, onHeaderTap) => educationCardBody(
                  textTheme: textTheme,
                  isCollpsed: isCollapsed,
                  onHeaderTap: onHeaderTap,
                ),
              ),
              SizedBox(height: 18.h),
              _QualificationCard(
                cardType: QualificationAndSkillsType.experience,
                bodyBuilder: (isCollapsed, onHeaderTap) => experienceCardBody(
                  textTheme: textTheme,
                  isCollpsed: isCollapsed,
                  onHeaderTap: onHeaderTap,
                ),
              ),
              SizedBox(height: 18.h),
              _QualificationCard(
                cardType: QualificationAndSkillsType.skills,
                bodyBuilder: (isCollapsed, onHeaderTap) => skillsCardBody(
                  textTheme: textTheme,
                  isCollpsed: isCollapsed,
                  onHeaderTap: onHeaderTap,
                ),
              ),
              SizedBox(height: 18.h),
              _QualificationCard(
                cardType: QualificationAndSkillsType.languages,
                bodyBuilder: (isCollapsed, onHeaderTap) => languagesCardBody(
                  textTheme: textTheme,
                  isCollpsed: isCollapsed,
                  onHeaderTap: onHeaderTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget collapsedCardDisplay({
    required TextTheme textTheme,
    required QualificationAndSkillsType cardType,
    required String number,
  }) {
    return Row(
      spacing: 13.w,
      children: [
        Container(
          height: 36.r,
          width: 36.r,
          decoration: BoxDecoration(
            color: getCardIconBgColor(cardType),
            borderRadius: BorderRadius.circular(60.r),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: SvgPicture.asset(getCardIcon(cardType)),
          ),
        ),
        Column(
          spacing: 4.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getCardTitle(cardType),
              style: textTheme.geist18Medium.copyWith(
                color: AppColors.cardTitleBlack,
                fontFamily: 'Reckless',
              ),
            ),
            Text(
              '$number ${getCardSubTitle(cardType)}',
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget educationCardBody({
    required TextTheme textTheme,
    required VoidCallback onHeaderTap,
    bool isCollpsed = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onHeaderTap,
            child: SizedBox(
              width: double.infinity,
              child: collapsedCardDisplay(
                textTheme: textTheme,
                cardType: QualificationAndSkillsType.education,
                number: '2',
              ),
            ),
          ),
          SizedBox(height: 25.h),
          if (!isCollpsed) ...[
            headingComponent(
              texttheme: textTheme,
              heading: 'Bachelor of Engineering',
              subHeading: 'Applied Electronics',
              headingColor: AppColors.headingBlue,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.schoolIcon,
              value: 'Harvard University',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.locationIcon,
              value: 'Dubai',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
            SizedBox(height: 32.h),
            headingComponent(
              texttheme: textTheme,
              heading: 'Diploma',
              subHeading: 'Electronics and Communication',
              headingColor: AppColors.headingBlue,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.schoolIcon,
              value: 'Harvard University',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.locationIcon,
              value: 'Dubai',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
          ],
        ],
      ),
    );
  }

  Widget experienceCardBody({
    required TextTheme textTheme,
    required VoidCallback onHeaderTap,
    bool isCollpsed = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onHeaderTap,
            child: SizedBox(
              width: double.infinity,
              child: collapsedCardDisplay(
                textTheme: textTheme,
                cardType: QualificationAndSkillsType.experience,
                number: '2',
              ),
            ),
          ),
          SizedBox(height: 25.h),
          if (!isCollpsed) ...[
            headingComponent(
              texttheme: textTheme,
              heading: 'Elixir Technologies',
              subHeading: 'Senior Tech Lead',
              headingColor: AppColors.tagColor,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.locationIcon,
              value: 'Dubai',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
            SizedBox(height: 32.h),
            headingComponent(
              texttheme: textTheme,
              heading: 'Dell Technologies',
              subHeading: 'Engineering Lead',
              headingColor: AppColors.tagColor,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.locationIcon,
              value: 'Dubai',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
          ],
        ],
      ),
    );
  }

  Widget skillsCardBody({
    required TextTheme textTheme,
    required VoidCallback onHeaderTap,
    bool isCollpsed = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onHeaderTap,
            child: SizedBox(
              width: double.infinity,
              child: collapsedCardDisplay(
                textTheme: textTheme,
                cardType: QualificationAndSkillsType.skills,
                number: '2',
              ),
            ),
          ),
          SizedBox(height: 25.h),
          if (!isCollpsed) ...[
            headingComponent(
              texttheme: textTheme,
              heading: 'React Development',
              subHeading: 'Intermediate',
              headingColor: AppColors.statusWarning,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.certificateIcon,
              value: 'AWS Solutions Architect',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
            SizedBox(height: 32.h),
            headingComponent(
              texttheme: textTheme,
              heading: 'Cloud Architect',
              subHeading: 'Begineer',
              headingColor: AppColors.statusWarning,
            ),
            SizedBox(height: 12.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.certificateIcon,
              value: 'Google Cloud Professional',
            ),
            SizedBox(height: 8.h),
            valueComponent(
              textTheme: textTheme,
              icon: AppAssets.calanderIcon,
              value: '1 Jan 2024 - 31 Dec 2026',
            ),
          ],
        ],
      ),
    );
  }

  Widget languagesCardBody({
    required TextTheme textTheme,
    required VoidCallback onHeaderTap,
    bool isCollpsed = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onHeaderTap,
            child: SizedBox(
              width: double.infinity,
              child: collapsedCardDisplay(
                textTheme: textTheme,
                cardType: QualificationAndSkillsType.languages,
                number: '2',
              ),
            ),
          ),
          SizedBox(height: 25.h),
          if (!isCollpsed) ...[
            languageRow(
              textTheme: textTheme,
              language: 'English',
              isPreferred: true,
            ),
            SizedBox(height: 18.h),
            languageRow(
              textTheme: textTheme,
              language: 'Tamil',
              isWrite: false,
            ),
            SizedBox(height: 18.h),
            languageRow(
              textTheme: textTheme,
              language: 'Hindi',
              isRead: false,
              isWrite: false,
            ),
          ],
        ],
      ),
    );
  }

  Widget languageProficiencyTag({
    required TextTheme textTheme,
    required String proficiency,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.cardFooterGreen,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        proficiency,
        style: textTheme.geist10Regular.copyWith(color: AppColors.tagTextGreen),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget languageText({
    required TextTheme textTheme,
    required String language,
    bool isPreferred = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isPreferred)
          Text(
            'Preferred',
            style: textTheme.geist10Regular.copyWith(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
            ),
          ),
        Text(
          language,
          style: textTheme.geist14Medium.copyWith(
            color: AppColors.statusNeutralText,
          ),
        ),
      ],
    );
  }

  Widget languageRow({
    required TextTheme textTheme,
    required String language,
    bool isPreferred = false,
    bool isSpeak = true,
    bool isRead = true,
    bool isWrite = true,
  }) {
    return Row(
      children: [
        Expanded(
          child: languageText(
            textTheme: textTheme,
            language: language,
            isPreferred: isPreferred,
          ),
        ),
        SizedBox(
          width: 135.w,
          child: languageProficiency(
            textTheme: textTheme,
            isSpeak: isSpeak,
            isRead: isRead,
            isWrite: isWrite,
          ),
        ),
      ],
    );
  }

  Widget languageProficiency({
    required TextTheme textTheme,
    bool isSpeak = true,
    bool isRead = true,
    bool isWrite = true,
  }) {
    return Row(
      spacing: 8.w,
      children: [
        if (isSpeak)
          languageProficiencyTag(textTheme: textTheme, proficiency: 'Speak'),
        if (isRead)
          languageProficiencyTag(textTheme: textTheme, proficiency: 'Read'),
        if (isWrite)
          languageProficiencyTag(textTheme: textTheme, proficiency: 'Write'),
      ],
    );
  }

  Widget headingComponent({
    required TextTheme texttheme,
    required String heading,
    required String subHeading,
    required Color headingColor,
  }) {
    return Column(
      spacing: 2.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: texttheme.geist14Medium.copyWith(
            color: headingColor,
            fontFamily: 'HostGrotesk',
          ),
        ),
        Text(
          subHeading,
          style: texttheme.geist12Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget valueComponent({
    required TextTheme textTheme,
    required String icon,
    required String value,
  }) {
    return Row(
      spacing: 6.w,
      children: [
        SvgPicture.asset(icon),
        Text(
          value,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.toastMessage,
          ),
        ),
      ],
    );
  }

  String getCardIcon(QualificationAndSkillsType cardType) {
    switch (cardType) {
      case QualificationAndSkillsType.education:
        return AppAssets.educationIcon;
      case QualificationAndSkillsType.experience:
        return AppAssets.experienceIcon;
      case QualificationAndSkillsType.skills:
        return AppAssets.skillsIcon;
      case QualificationAndSkillsType.languages:
        return AppAssets.languageIcon;
    }
  }

  String getCardTitle(QualificationAndSkillsType cardType) {
    switch (cardType) {
      case QualificationAndSkillsType.education:
        return 'My Education';
      case QualificationAndSkillsType.experience:
        return 'My Experience';
      case QualificationAndSkillsType.skills:
        return 'My Skills';
      case QualificationAndSkillsType.languages:
        return 'My Languages';
    }
  }

  String getCardSubTitle(QualificationAndSkillsType cardType) {
    switch (cardType) {
      case QualificationAndSkillsType.education:
      case QualificationAndSkillsType.experience:
      case QualificationAndSkillsType.skills:
        return 'Graduations';
      case QualificationAndSkillsType.languages:
        return 'Languages';
    }
  }

  Color getCardIconBgColor(QualificationAndSkillsType cardType) {
    switch (cardType) {
      case QualificationAndSkillsType.education:
        return AppColors.educationCardIconBg;
      case QualificationAndSkillsType.experience:
        return AppColors.experienceCardIconBg;
      case QualificationAndSkillsType.skills:
        return AppColors.skillsCardIconBg;
      case QualificationAndSkillsType.languages:
        return AppColors.languageCardIconBg;
    }
  }
}

class _QualificationCard extends StatefulWidget {
  const _QualificationCard({required this.cardType, required this.bodyBuilder});

  final QualificationAndSkillsType cardType;
  final Widget Function(bool isCollapsed, VoidCallback onHeaderTap) bodyBuilder;

  @override
  State<_QualificationCard> createState() => _QualificationCardState();
}

class _QualificationCardState extends State<_QualificationCard> {
  bool _isCollapsed = true;

  void _toggleCollapsed() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: getCardBorderGradientColors(widget.cardType),
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 16.r,
            spreadRadius: -6.r,
            color: AppColors.darkBlueShadow.withValues(alpha: 0.03),
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17.r),
        child: ColoredBox(
          color: AppColors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SvgPicture.asset(
                      getCardBg(widget.cardType),
                      width: constraints.maxWidth,
                      fit: BoxFit.fitWidth,
                    );
                  },
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: widget.bodyBuilder(_isCollapsed, _toggleCollapsed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> getCardBorderGradientColors(QualificationAndSkillsType cardType) {
  switch (cardType) {
    case QualificationAndSkillsType.education:
      return [AppColors.borderBlue, AppColors.transparent];
    case QualificationAndSkillsType.experience:
      return [
        AppColors.purpleBorderColor,
        AppColors.purpleBorderColor.withValues(alpha: 0.3),
      ];
    case QualificationAndSkillsType.skills:
      return [AppColors.peachBorderColor, AppColors.transparent];
    case QualificationAndSkillsType.languages:
      return [AppColors.greenBorderColor, AppColors.transparent];
  }
}

String getCardBg(QualificationAndSkillsType cardType) {
  switch (cardType) {
    case QualificationAndSkillsType.education:
      return AppAssets.blueCardBg;
    case QualificationAndSkillsType.experience:
      return AppAssets.purpleCardBg;
    case QualificationAndSkillsType.skills:
      return AppAssets.peachCardBg;
    case QualificationAndSkillsType.languages:
      return AppAssets.greenCardBg;
  }
}
