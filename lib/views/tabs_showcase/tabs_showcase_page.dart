import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class TabsShowcasePage extends StatefulWidget {
  const TabsShowcasePage({super.key});

  @override
  State<TabsShowcasePage> createState() => _TabsShowcasePageState();
}

class _TabsShowcasePageState extends State<TabsShowcasePage> {
  bool _isArabic = false;
  int _segmentedIndex = 0;
  int _underlineIndex = 0;
  int _underlineCompactIndex = 0;

  static const List<String> _enLabels = <String>[
    'Option',
    'Option',
    'Option',
    'Option',
    'Option',
  ];

  static const List<String> _arLabels = <String>[
    'خيار',
    'خيار',
    'خيار',
    'خيار',
    'خيار',
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextDirection direction =
        _isArabic ? TextDirection.rtl : TextDirection.ltr;
    final List<String> labels = _isArabic ? _arLabels : _enLabels;
    final TextStyle sectionStyle =
        textTheme.geist14SemiBold.copyWith(color: AppColors.neutral500);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Tabs', style: textTheme.geist18SemiBold),
        actions: <Widget>[
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
              Text('Segmented', style: sectionStyle),
              SizedBox(height: 12.h),
              AppSegmentedTabs(
                labels: labels,
                selectedIndex: _segmentedIndex,
                onChanged: (int i) => setState(() => _segmentedIndex = i),
              ),
              SizedBox(height: 32.h),
              Text('Underline', style: sectionStyle),
              SizedBox(height: 12.h),
              AppUnderlineTabs(
                labels: labels,
                selectedIndex: _underlineIndex,
                onChanged: (int i) => setState(() => _underlineIndex = i),
              ),
              SizedBox(height: 32.h),
              Text('Underline - Compact', style: sectionStyle),
              SizedBox(height: 12.h),
              AppUnderlineTabs(
                labels: labels,
                selectedIndex: _underlineCompactIndex,
                onChanged: (int i) =>
                    setState(() => _underlineCompactIndex = i),
                size: AppUnderlineTabsSize.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
