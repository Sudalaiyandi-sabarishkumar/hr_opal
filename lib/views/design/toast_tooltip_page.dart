import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class ToastTooltipPage extends StatefulWidget {
  const ToastTooltipPage({super.key});

  @override
  State<ToastTooltipPage> createState() => _ToastTooltipPageState();
}

class _ToastTooltipPageState extends State<ToastTooltipPage> {
  bool _isArabic = false;
  bool _isDark = false;

  static const Map<AppToastStatus, List<String>> _toastEn =
      <AppToastStatus, List<String>>{
        AppToastStatus.message: <String>[
          'This is a Message',
          'Add description in this place',
        ],
        AppToastStatus.success: <String>[
          'This is a Success',
          'Add description in this place',
        ],
        AppToastStatus.warning: <String>[
          'This is an Alert',
          'Add description in this place',
        ],
        AppToastStatus.danger: <String>[
          'This is an Error',
          'Add description in this place',
        ],
      };

  static const Map<AppToastStatus, List<String>> _toastAr =
      <AppToastStatus, List<String>>{
        AppToastStatus.message: <String>['هذه رسالة', 'أضف الوصف هنا'],
        AppToastStatus.success: <String>['هذه رسالة نجاح', 'أضف الوصف هنا'],
        AppToastStatus.warning: <String>['هذا تنبيه', 'أضف الوصف هنا'],
        AppToastStatus.danger: <String>['هذا خطأ', 'أضف الوصف هنا'],
      };

  static const List<AppTooltipPlacement> _placements = <AppTooltipPlacement>[
    AppTooltipPlacement.top,
    AppTooltipPlacement.bottom,
    AppTooltipPlacement.left,
    AppTooltipPlacement.right,
  ];

  static const List<AppTooltipAlign> _aligns = <AppTooltipAlign>[
    AppTooltipAlign.start,
    AppTooltipAlign.center,
    AppTooltipAlign.end,
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextDirection direction = _isArabic
        ? TextDirection.rtl
        : TextDirection.ltr;
    final AppToastSurface toastSurface = _isDark
        ? AppToastSurface.dark
        : AppToastSurface.light;
    final AppTooltipSurface tooltipSurface = _isDark
        ? AppTooltipSurface.dark
        : AppTooltipSurface.light;
    final Map<AppToastStatus, List<String>> toastCopy = _isArabic
        ? _toastAr
        : _toastEn;
    final Color pageBackground = _isDark
        ? AppColors.toastDarkSurface
        : AppColors.white;
    final Color headingColor = _isDark ? AppColors.white : AppColors.textPrimary;
    final TextStyle sectionStyle = textTheme.geist16SemiBold.copyWith(
      color: headingColor,
    );
    final String tooltipMessage = _isArabic ? 'أنا تلميح' : 'I am a tooltip';

    return ColoredBox(
      color: pageBackground,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AppSegmentedTabs(
                  labels: const <String>['Light', 'Dark'],
                  selectedIndex: _isDark ? 1 : 0,
                  onChanged: (int i) => setState(() => _isDark = i == 1),
                ),
                SizedBox(width: 12.w),
                AppSegmentedTabs(
                  labels: const <String>['EN', 'AR'],
                  selectedIndex: _isArabic ? 1 : 0,
                  onChanged: (int i) => setState(() => _isArabic = i == 1),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Directionality(
              textDirection: direction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Toast', style: sectionStyle),
                  SizedBox(height: 16.h),
                  for (final AppToastStatus status
                      in toastCopy.keys) ...<Widget>[
                    AppToast(
                      title: toastCopy[status]![0],
                      description: toastCopy[status]![1],
                      status: status,
                      surface: toastSurface,
                      actionLabel: _isArabic ? 'تسمية' : 'Label',
                      onActionTap: () {},
                      onClose: () {},
                    ),
                    SizedBox(height: 12.h),
                  ],
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: <Widget>[
                      for (final AppToastStatus status in toastCopy.keys)
                        CustomButton(
                          buttonName: toastCopy[status]![0],
                          variant: AppButtonVariant.outline,
                          isFullWidth: false,
                          onTap: () => AppToast.show(
                            context,
                            title: toastCopy[status]![0],
                            description: toastCopy[status]![1],
                            status: status,
                            surface: toastSurface,
                            textDirection: direction,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Text('Tooltip', style: sectionStyle),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 24.w,
                    runSpacing: 16.h,
                    children: <Widget>[
                      for (final AppTooltipPlacement placement
                          in const <AppTooltipPlacement>[
                            AppTooltipPlacement.top,
                            AppTooltipPlacement.bottom,
                          ])
                        for (final AppTooltipAlign align in _aligns)
                          AppTooltipTrigger(
                            message: tooltipMessage,
                            placement: placement,
                            align: align,
                            surface: tooltipSurface,
                            textDirection: direction,
                            child: Text(
                              '${placement.name}-${align.name}',
                              style: textTheme.geist14Medium.copyWith(
                                color: headingColor,
                              ),
                            ),
                          ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Wrap(
                    spacing: 24.w,
                    runSpacing: 24.h,
                    children: <Widget>[
                      for (final AppTooltipPlacement placement in _placements)
                        for (final AppTooltipAlign align in _aligns)
                          AppTooltip(
                            message: tooltipMessage,
                            placement: placement,
                            align: align,
                            surface: tooltipSurface,
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
