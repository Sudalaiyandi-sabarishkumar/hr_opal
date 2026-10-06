import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _weekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  late DateTime _now = DateTime.now();
  Timer? _timer;
  bool _clockedIn = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (Timer _) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeLabel {
    final int hour = _now.hour % 12 == 0 ? 12 : _now.hour % 12;
    final String period = _now.hour < 12 ? 'AM' : 'PM';
    return '$hour:${_now.minute.toString().padLeft(2, '0')} $period';
  }

  void _go(String routeName) {
    context.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppAssets.bg4Image,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _topBar(),
                SizedBox(height: 28.h),
                _clockAndLeaveRow(),
                SizedBox(height: 28.h),
                _quickActions(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _topBar() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            SvgPicture.asset(AppAssets.homeMenu, width: 28.r, height: 28.r),
            Positioned(
              right: -2.w,
              top: -2.h,
              child: Container(
                width: 9.r,
                height: 9.r,
                decoration: const BoxDecoration(
                  color: AppColors.toastWarning,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${_weekdays[_now.weekday - 1]} ${_now.day}',
                style: textTheme.geist14Regular.copyWith(
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 12.w),
              SvgPicture.asset(
                AppAssets.payrollCloud,
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '23°',
                style: textTheme.geist14Regular.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            context.push(RouteConstants.profilePage);
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.7),
                width: 0.5.w,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.femaleImage,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _clockAndLeaveRow() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 62.h),
      child: IntrinsicHeight(
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.purple1.withValues(alpha: 0.5),
                  width: 3.w,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _timeLabel,
                          style: textTheme.geist16Medium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _clockedIn
                              ? 'You are clocked in'
                              : 'You are clocked out',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.geist10Regular.copyWith(
                            color: AppColors.toastMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () => setState(() => _clockedIn = !_clockedIn),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        _clockedIn ? 'Clock Out' : 'Clock In',
                        style: textTheme.geist12Regular.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: GestureDetector(
              onTap: () => _go(RouteConstants.myLeavesPage),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.secondary500,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      AppAssets.requestBeach,
                      width: 26.r,
                      height: 26.r,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Apply Leaves',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.geist14Medium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '23 days available',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.geist10Regular.copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 16.r,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _quickActions() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _QuickAction(
            icon: AppAssets.messageAdd,
            label: 'Raise Request',
            onTap: () => _go(RouteConstants.requestPage),
          ),
        ),
        Expanded(
          child: _QuickAction(
            icon: AppAssets.coinDollar,
            label: 'My Payslips',
            onTap: () {
              _go(RouteConstants.payslipsPage);
            }
            ,
          ),
        ),
        Expanded(
          child: _QuickAction(
            icon: AppAssets.policy,
            label: 'HR Policies',
            onTap: () => _go(RouteConstants.hrPoliciesPage),
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            width: 46.r,
            height: 46.r,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.55),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withValues(alpha: 0.7)),
            ),
            child: Center(
              child: SvgPicture.asset(icon, width: 24.r, height: 24.r),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: textTheme.geist12Regular.copyWith(
              color: AppColors.statusNeutralText,
            ),
          ),
        ],
      ),
    );
  }
}
