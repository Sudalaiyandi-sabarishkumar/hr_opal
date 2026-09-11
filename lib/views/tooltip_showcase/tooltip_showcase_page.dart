import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class TooltipShowcasePage extends StatefulWidget {
  const TooltipShowcasePage({super.key});

  @override
  State<TooltipShowcasePage> createState() => _TooltipShowcasePageState();
}

class _TooltipShowcasePageState extends State<TooltipShowcasePage> {
  bool _isDark = false;
  bool _isArabic = false;

  static const List<AppTooltipSurface> _surfaces = <AppTooltipSurface>[
    AppTooltipSurface.light,
    AppTooltipSurface.dark,
  ];

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

  static const List<TextDirection> _directions = <TextDirection>[
    TextDirection.ltr,
    TextDirection.rtl,
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle sectionStyle = textTheme.geist14SemiBold.copyWith(
      color: AppColors.textSecondary,
    );
    final TextDirection demoDirection =
        _isArabic ? TextDirection.rtl : TextDirection.ltr;
    final Brightness demoBrightness =
        _isDark ? Brightness.dark : Brightness.light;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Tooltip', style: textTheme.geist18SemiBold),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Long press demo', style: sectionStyle),
            SizedBox(height: 12.h),
            Theme(
              data: Theme.of(context).copyWith(brightness: demoBrightness),
              child: Directionality(
                textDirection: demoDirection,
                child: Wrap(
                  spacing: 24.w,
                  runSpacing: 16.h,
                  children: <Widget>[
                    for (final AppTooltipPlacement placement in const <
                        AppTooltipPlacement
                    >[AppTooltipPlacement.top, AppTooltipPlacement.bottom])
                      for (final AppTooltipAlign align in _aligns)
                        AppTooltipTrigger(
                          message: _isArabic ? 'أنا تلميح' : 'I am a tooltip',
                          placement: placement,
                          align: align,
                          child: Text(
                            '${placement.name}-${align.name}',
                            style: textTheme.geist14Medium,
                          ),
                        ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
            for (final TextDirection direction in _directions)
              for (final AppTooltipSurface surface in _surfaces)
                _combinationSection(direction, surface),
          ],
        ),
      ),
    );
  }

  Widget _combinationSection(TextDirection direction, AppTooltipSurface surface) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isArabic = direction == TextDirection.rtl;
    final String message = isArabic ? 'أنا تلميح' : 'I am a tooltip';
    final String title =
        '${isArabic ? 'Arabic' : 'English'} · ${surface == AppTooltipSurface.light ? 'Light' : 'Dark'}';

    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textTheme.geist14SemiBold.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          Directionality(
            textDirection: direction,
            child: Wrap(
              spacing: 24.w,
              runSpacing: 24.h,
              children: <Widget>[
                for (final AppTooltipPlacement placement in _placements)
                  for (final AppTooltipAlign align in _aligns)
                    AppTooltip(
                      message: message,
                      placement: placement,
                      align: align,
                      surface: surface,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
