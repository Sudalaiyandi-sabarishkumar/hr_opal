import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../shared_components/button/custom_button.dart';
import '../profile/family_address_details.dart';

const String _announcementsJson = r'''
[
  {
    "type": "hrPolicy",
    "title": "Updated Leave Policy Effective Sep 1",
    "date": "22 Aug 2026",
    "announcement": "Review the latest changes to leave eligibility, advance notice requirements, and carry-forward rules.\n\nThe updated policy comes into effect from 1 Sep 2026 and applies to all full-time employees.\n\nPlease read the policy document on the HR portal and reach out to the HR team for any clarifications.\n\n-HR Team"
  },
  {
    "type": "benefits",
    "title": "Introduction of Hybrid Work Model",
    "date": "15 Sep 2026",
    "announcement": "Details on new remote work arrangements, office attendance guidelines, and team coordination.\n\nEmployees can now work remotely up to two days a week, subject to manager approval and team requirements.\n\nMore details will be shared by your respective managers.\n\n-HR Team"
  },
  {
    "type": "policy",
    "title": "Annual Review Cycle Adjustments",
    "date": "30 Sep 2026",
    "announcement": "Changes to timing and criteria for employee performance evaluations across all departments.\n\nThe annual review cycle will now begin in January, with mid-year check-ins scheduled for July.\n\nPlease connect with your manager to understand how the new criteria apply to your role.\n\n-HR Team"
  },
  {
    "type": "benefits",
    "title": "Enhanced Wellness Program",
    "date": "10 Oct 2026",
    "announcement": "Overview of new health initiatives, mental health support, and fitness benefits.\n\nOur company hosts an annual health and wellness program designed to support employees well-being.\n\nThe program includes health screenings, fitness activities, and wellness workshops to promote a healthier lifestyle throughout the year.\n\nThe Program starts on 12 Oct 2026 from 10:00 AM at the Main conference hall. All Employees are encouraged to take part\n\n-HR Team"
  },
  {
    "type": "employeeEngagements",
    "title": "New Skills Development Programs",
    "date": "20 Oct 2026",
    "announcement": "Introduction of workshops, online courses, and certification opportunities for all employees.\n\nEach employee can enroll in up to three programs this year, fully sponsored by the company.\n\nRegistrations are open on the learning portal until 31 Oct 2026.\n\n-HR Team"
  }
]
''';

class AnnouncementModel {
  const AnnouncementModel({
    required this.type,
    required this.title,
    required this.announcement,
    required this.date,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      type: AnnouncementType.values.firstWhere(
        (AnnouncementType e) => e.name == json['type'],
        orElse: () => AnnouncementType.policy,
      ),
      title: json['title'] as String,
      announcement: json['announcement'] as String,
      date: json['date'] as String,
    );
  }

  final AnnouncementType type;
  final String title;
  final String announcement;
  final String date;
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  late final List<AnnouncementModel> _announcements;

  @override
  void initState() {
    super.initState();
    _announcements = (jsonDecode(_announcementsJson) as List<dynamic>)
        .map(
          (dynamic e) => AnnouncementModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(title: 'Announcements', textTheme: textTheme),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            pageBackground(),
            pageForeground(textTheme: textTheme, context: context),
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

  Widget pageForeground({
    required TextTheme textTheme,
    required BuildContext context,
  }) {
    return Positioned(
      top: 101.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h),
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
        child: Material(
          type: MaterialType.transparency,
          child: ListView.separated(
            padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
            itemCount: _announcements.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 24.h),
            itemBuilder: (BuildContext context, int index) {
              final AnnouncementModel item = _announcements[index];
              return announcementTile(
                textTheme: textTheme,
                context: context,
                announcementType: item.type,
                title: item.title,
                announcement: item.announcement,
                date: item.date,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget announcementTile({
    required TextTheme textTheme,
    required BuildContext context,
    required AnnouncementType announcementType,
    required String title,
    required String announcement,
    required String date,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      horizontalTitleGap: 8.w,
      minLeadingWidth: 39.r,
      titleAlignment: ListTileTitleAlignment.bottom,
      leading: announcementIcon(),
      title: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              typeTag(textTheme: textTheme, announcementType: announcementType),
              dateText(textTheme: textTheme, date: date),
            ],
          ),
          announcementDetails(
            textTheme: textTheme,
            title: title,
            announcement: announcement,
          ),
        ],
      ),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return AnnouncementDetailsBottomSheet(
              widget: bottomSheetWidget(
                textTheme: textTheme,
                announcementType: announcementType,
                title: title,
                announcement: announcement,
                date: date,
              ),
            );
          },
        );
      },
    );
  }

  Widget announcementDetails({
    required TextTheme textTheme,
    required String title,
    required String announcement,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.geist12Regular.copyWith(
            fontSize: 13.sp,
            color: AppColors.statusNeutralText,
          ),
        ),
        Text(
          announcement,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget announcementIcon() {
    return Container(
      height: 39.r,
      width: 39.r,
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(7.8.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.announcementIcon,
          height: 20.8.r,
          width: 20.8.r,
        ),
      ),
    );
  }

  Widget typeTag({
    required TextTheme textTheme,
    required AnnouncementType announcementType,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: getTypeTagBgColor(announcementType),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        getTypeTagText(announcementType),
        style: textTheme.geist10Regular.copyWith(
          fontSize: 11.sp,
          color: getTypeTagTextColor(announcementType),
        ),
      ),
    );
  }

  Widget dateText({required TextTheme textTheme, required String date}) {
    return Text(
      date,
      style: textTheme.geist10Regular.copyWith(color: AppColors.textSecondary),
    );
  }

  Color getTypeTagBgColor(AnnouncementType announcementType) {
    switch (announcementType) {
      case AnnouncementType.benefits:
        return AppColors.statusSuccessSubtleBg;
      case AnnouncementType.employeeEngagements:
        return AppColors.bg2Blue;
      case AnnouncementType.hrPolicy:
        return AppColors.accordionPurpleBg;
      case AnnouncementType.policy:
        return AppColors.accordionYellowBg;
    }
  }

  Color getTypeTagTextColor(AnnouncementType announcementType) {
    switch (announcementType) {
      case AnnouncementType.benefits:
        return AppColors.toastSuccess;
      case AnnouncementType.employeeEngagements:
        return AppColors.calanderTextBlue;
      case AnnouncementType.hrPolicy:
        return AppColors.tagColor;
      case AnnouncementType.policy:
        return AppColors.statusWarning;
    }
  }

  String getTypeTagText(AnnouncementType announcementType) {
    switch (announcementType) {
      case AnnouncementType.benefits:
        return 'Benefits';
      case AnnouncementType.employeeEngagements:
        return 'Employee Engagement';
      case AnnouncementType.hrPolicy:
        return 'HR Policy';
      case AnnouncementType.policy:
        return 'Policy';
    }
  }

  Widget bottomSheetWidget({
    required TextTheme textTheme,
    required AnnouncementType announcementType,
    required String title,
    required String announcement,
    required String date,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcement',
          style: textTheme.geist24SemiBold.copyWith(
            color: AppColors.darkPurple2,
            fontFamily: 'HostGrotesk',
          ),
        ),
        SizedBox(height: 32.h),
        typeTag(textTheme: textTheme, announcementType: announcementType),
        SizedBox(height: 8.h),
        Text(
          date,
          style: textTheme.geist10Regular.copyWith(
            color: AppColors.statusNeutralText,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: textTheme.geist16Regular.copyWith(
            color: AppColors.statusNeutralText,
          ),
        ),
        SizedBox(height: 18.h),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              announcement,
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.toastMessage,
              ),
            ),
          ),
        ),

        SizedBox(height: 18.h),

        CustomButton(
          buttonName: 'Done',
          variant: AppButtonVariant.secondary,
          height: 52.h,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }
}

class AnnouncementDetailsBottomSheet extends StatelessWidget {
  const AnnouncementDetailsBottomSheet({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 525.h,
        margin: EdgeInsets.fromLTRB(12.5.w, 0, 12.5.w, 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AppAssets.bottomSheetBg,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28.5.w, 24.h, 28.5.w, 24.h),
                child: widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
