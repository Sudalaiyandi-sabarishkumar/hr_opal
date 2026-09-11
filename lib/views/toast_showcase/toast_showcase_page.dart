import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class ToastShowcasePage extends StatefulWidget {
  const ToastShowcasePage({super.key});

  @override
  State<ToastShowcasePage> createState() => _ToastShowcasePageState();
}

class _ToastShowcasePageState extends State<ToastShowcasePage> {
  bool _isArabic = false;
  bool _isDark = false;

  static const Map<AppToastStatus, List<String>> _en = <AppToastStatus, List<String>>{
    AppToastStatus.message: <String>['This is a Message', 'Add description in this place'],
    AppToastStatus.success: <String>['This is a Success', 'Add description in this place'],
    AppToastStatus.warning: <String>['This is an Alert', 'Add description in this place'],
    AppToastStatus.danger: <String>['This is an Error', 'Add description in this place'],
  };

  static const Map<AppToastStatus, List<String>> _ar = <AppToastStatus, List<String>>{
    AppToastStatus.message: <String>['هذه رسالة', 'أضف الوصف هنا'],
    AppToastStatus.success: <String>['هذه رسالة نجاح', 'أضف الوصف هنا'],
    AppToastStatus.warning: <String>['هذا تنبيه', 'أضف الوصف هنا'],
    AppToastStatus.danger: <String>['هذا خطأ', 'أضف الوصف هنا'],
  };

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextDirection direction =
        _isArabic ? TextDirection.rtl : TextDirection.ltr;
    final Map<AppToastStatus, List<String>> copy = _isArabic ? _ar : _en;
    final AppToastSurface surface =
        _isDark ? AppToastSurface.dark : AppToastSurface.light;

    return Scaffold(
      backgroundColor: !_isDark ? AppColors.toastDarkSurface : AppColors.white,
      appBar: AppBar(
        backgroundColor: _isDark ? AppColors.toastDarkSurface : AppColors.white,
        title: Text(
          'Toast',
          style: textTheme.geist18SemiBold.copyWith(
            color: _isDark ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Center(
              child: AppSegmentedTabs(
                labels: const <String>['Light', 'Dark'],
                selectedIndex: _isDark ? 1 : 0,
                onChanged: (int i) => setState(() => _isDark = i == 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: AppSegmentedTabs(
                labels: const <String>['EN', 'AR'],
                selectedIndex: _isArabic ? 1 : 0,
                onChanged: (int i) => setState(() => _isArabic = i == 1),
              ),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: direction,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final AppToastStatus status in copy.keys) ...<Widget>[
                AppToast(
                  title: copy[status]![0],
                  description: copy[status]![1],
                  status: status,
                  surface: surface,
                  actionLabel: 'Label',
                  onActionTap: () {},
                  onClose: () {},
                ),
                SizedBox(height: 16.h),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
