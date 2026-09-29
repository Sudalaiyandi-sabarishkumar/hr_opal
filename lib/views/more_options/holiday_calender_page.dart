import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../profile/family_address_details.dart';

const String _holidayJson = '''
[
  {
    "month": "January",
    "holidays": [
      {"date": "26", "month": "JAN", "name": "Republic Day", "day": "Sunday", "color": "purple", "type": "none"}
    ]
  },
  {
    "month": "March",
    "holidays": [
      {"date": "14", "month": "MAR", "name": "Maha Shivaratri", "day": "Friday", "color": "green", "type": "optional"},
      {"date": "31", "month": "MAR", "name": "Eid-ul-Fitr", "day": "Monday", "color": "yellow", "type": "none"}
    ]
  },
  {
    "month": "April",
    "holidays": [
      {"date": "10", "month": "APR", "name": "Mahavir Jayanti", "day": "Thursday", "color": "orange", "type": "restricted"},
      {"date": "14", "month": "APR", "name": "Dr. Ambedkar Jayanti", "day": "Monday", "color": "blue", "type": "none"},
      {"date": "18", "month": "APR", "name": "Good Friday", "day": "Friday", "color": "green", "type": "none"}
    ]
  },
  {
    "month": "May",
    "holidays": [
      {"date": "12", "month": "MAY", "name": "Buddha Purnima", "day": "Monday", "color": "purple", "type": "none"}
    ]
  },
  {
    "month": "June",
    "holidays": [
      {"date": "11", "month": "JUN", "name": "Eid-ul-Adha", "day": "Monday", "color": "yellow", "type": "none"}
    ]
  },
  {
    "month": "July",
    "holidays": [
      {"date": "6", "month": "JUL", "name": "Muharram", "day": "Sunday", "color": "purple", "type": "none"}
    ]
  }
]
''';

class HolidayModel {
  const HolidayModel({
    required this.date,
    required this.month,
    required this.name,
    required this.day,
    required this.color,
    required this.type,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json['date'] as String,
      month: json['month'] as String,
      name: json['name'] as String,
      day: json['day'] as String,
      color: HolidayCalenderColor.values.firstWhere(
        (HolidayCalenderColor e) => e.name == json['color'],
        orElse: () => HolidayCalenderColor.purple,
      ),
      type: HolidayType.values.firstWhere(
        (HolidayType e) => e.name == json['type'],
        orElse: () => HolidayType.none,
      ),
    );
  }

  final String date;
  final String month;
  final String name;
  final String day;
  final HolidayCalenderColor color;
  final HolidayType type;
}

class HolidayMonthModel {
  const HolidayMonthModel({required this.month, required this.holidays});

  factory HolidayMonthModel.fromJson(Map<String, dynamic> json) {
    return HolidayMonthModel(
      month: json['month'] as String,
      holidays: (json['holidays'] as List<dynamic>)
          .map((dynamic e) => HolidayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String month;
  final List<HolidayModel> holidays;
}

class HolidayCalenderPage extends StatefulWidget {
  const HolidayCalenderPage({super.key});

  @override
  State<HolidayCalenderPage> createState() => _HolidayCalenderPageState();
}

class _HolidayCalenderPageState extends State<HolidayCalenderPage> {
  late final List<HolidayMonthModel> _months;

  @override
  void initState() {
    super.initState();
    _months = (jsonDecode(_holidayJson) as List<dynamic>)
        .map(
          (dynamic e) => HolidayMonthModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: ProfileAppBar(title: 'Holiday Calendar', textTheme: textTheme),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
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
        padding: EdgeInsets.symmetric(horizontal: 28.w)
            .copyWith(top: 26.h, bottom: 20.h),
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
        child: monthList(textTheme: textTheme),
      ),
    );
  }

  Widget monthList({required TextTheme textTheme}) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _months.length,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 20.h),
      itemBuilder: (BuildContext context, int index) {
        final HolidayMonthModel month = _months[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            monthText(textTheme: textTheme, monthName: month.month),
            SizedBox(height: 8.h),
            holidayList(textTheme: textTheme, holidays: month.holidays),
          ],
        );
      },
    );
  }

  Widget holidayList({
    required TextTheme textTheme,
    required List<HolidayModel> holidays,
  }) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: holidays.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8.h),
      itemBuilder: (BuildContext context, int index) {
        final HolidayModel holiday = holidays[index];
        return holidayComponent(
          textTheme: textTheme,
          date: holiday.date,
          month: holiday.month,
          holidayName: holiday.name,
          day: holiday.day,
          holidayCalenderColor: holiday.color,
          holidayType: holiday.type,
        );
      },
    );
  }

  Widget monthText({required TextTheme textTheme, required String monthName}) {
    return Text(
      monthName,
      style: textTheme.geist14Medium.copyWith(
        fontFamily: 'HostGrotesk',
        color: AppColors.secondary500,
      ),
    );
  }

  Widget holidayComponent({
    required TextTheme textTheme,
    required String date,
    required String month,
    required String holidayName,
    required String day,
    required HolidayCalenderColor holidayCalenderColor,
    HolidayType holidayType = HolidayType.none,
  }) {
    return Row(
      spacing: 17.w,
      children: <Widget>[
        dayDateComponent(
          textTheme: textTheme,
          date: date,
          month: month,
          holidayCalenderColor: holidayCalenderColor,
        ),
        Expanded(
          child: holidayDetails(
            textTheme: textTheme,
            holidayName: holidayName,
            day: day,
            holidayType: holidayType,
          ),
        ),
      ],
    );
  }

  Widget dayDateComponent({
    required TextTheme textTheme,
    required String date,
    required String month,
    required HolidayCalenderColor holidayCalenderColor,
  }) {
    return Container(
      width: 46.w,
      padding: EdgeInsets.fromLTRB(3.w, 4.h, 3.w, 3.w),
      decoration: BoxDecoration(
        color: getCalendarBgColor(holidayCalenderColor),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        spacing: 2.h,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.w, 4.h, 0.w, 4.w),
            decoration: BoxDecoration(
              color: getCalendarBg2Color(holidayCalenderColor),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Center(
              child: Text(
                date,
                style: textTheme.geist16Regular.copyWith(
                  color: getCalendarTextColor(holidayCalenderColor),
                ),
              ),
            ),
          ),
          Text(
            month,
            style: textTheme.geist10Medium.copyWith(
              color: getCalendarTextColor(holidayCalenderColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget holidayDetails({
    required TextTheme textTheme,
    required String holidayName,
    required String day,
    HolidayType holidayType = HolidayType.none,
  }) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          spacing: 8.w,
          children: <Widget>[
            Flexible(
              child: Text(
                holidayName,
                overflow: TextOverflow.ellipsis,
                style: textTheme.geist14Regular.copyWith(
                  color: AppColors.statusNeutralText,
                ),
              ),
            ),
            if (holidayType != HolidayType.none)
              typeTag(textTheme: textTheme, type: holidayType),
          ],
        ),
        Text(
          day,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.toastMessage,
          ),
        ),
      ],
    );
  }

  Widget typeTag({required TextTheme textTheme, required HolidayType type}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: type == HolidayType.optional
            ? AppColors.accordionPurpleBg
            : AppColors.statusWarningSubtleBg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        type == HolidayType.optional ? 'Optional' : 'Restricted',
        style: textTheme.geist10Regular.copyWith(
          fontSize: 11.sp,
          color: type == HolidayType.optional
              ? AppColors.tagColor
              : AppColors.statusWarning,
        ),
      ),
    );
  }

  Color getCalendarBgColor(HolidayCalenderColor holidayCalenderColor) {
    switch (holidayCalenderColor) {
      case HolidayCalenderColor.purple:
        return AppColors.calanderBgPurple;
      case HolidayCalenderColor.green:
        return AppColors.calanderBgGreen;
      case HolidayCalenderColor.yellow:
        return AppColors.calanderBgYellow;
      case HolidayCalenderColor.orange:
        return AppColors.calanderBgOrange;
      case HolidayCalenderColor.blue:
        return AppColors.calanderBgBlue;
    }
  }

  Color getCalendarBg2Color(HolidayCalenderColor holidayCalenderColor) {
    switch (holidayCalenderColor) {
      case HolidayCalenderColor.purple:
        return AppColors.purple2;
      case HolidayCalenderColor.green:
        return AppColors.statusSuccessSubtleBg;
      case HolidayCalenderColor.yellow:
        return AppColors.accordionYellowBg;
      case HolidayCalenderColor.orange:
        return AppColors.statusDangerSubtleBg;
      case HolidayCalenderColor.blue:
        return AppColors.bg2Blue;
    }
  }

  Color getCalendarTextColor(HolidayCalenderColor holidayCalenderColor) {
    switch (holidayCalenderColor) {
      case HolidayCalenderColor.purple:
        return AppColors.calanderTextPurple;
      case HolidayCalenderColor.green:
        return AppColors.calanderTextGreen;
      case HolidayCalenderColor.yellow:
        return AppColors.calanderTextYellow;
      case HolidayCalenderColor.orange:
        return AppColors.calanderTextOrange;
      case HolidayCalenderColor.blue:
        return AppColors.calanderTextBlue;
    }
  }
}
