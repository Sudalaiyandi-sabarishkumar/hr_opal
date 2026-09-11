import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';

class TabsButtonsModalDrawerPage extends StatefulWidget {
  const TabsButtonsModalDrawerPage({super.key});

  @override
  State<TabsButtonsModalDrawerPage> createState() =>
      _TabsButtonsModalDrawerPageState();
}

class _TabsButtonsModalDrawerPageState
    extends State<TabsButtonsModalDrawerPage> {
  bool _isArabic = false;
  int _segmentedIndex = 0;
  int _underlineIndex = 0;
  int _underlineCompactIndex = 0;

  static const List<AppButtonVariant> _buttonVariants = <AppButtonVariant>[
    AppButtonVariant.primary,
    AppButtonVariant.secondary,
    AppButtonVariant.dark,
    AppButtonVariant.light,
    AppButtonVariant.subtle,
    AppButtonVariant.outline,
  ];

  static const List<AppButtonSize> _buttonSizes = <AppButtonSize>[
    AppButtonSize.large,
    AppButtonSize.medium,
    AppButtonSize.small,
  ];

  static const List<AppDrawerPlacement> _drawerPlacements =
      <AppDrawerPlacement>[
        AppDrawerPlacement.top,
        AppDrawerPlacement.bottom,
        AppDrawerPlacement.left,
        AppDrawerPlacement.right,
      ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle sectionStyle = textTheme.geist16SemiBold;
    final TextStyle subStyle = textTheme.geist14SemiBold.copyWith(
      color: AppColors.textSecondary,
    );
    final TextDirection direction = _isArabic
        ? TextDirection.rtl
        : TextDirection.ltr;
    final List<String> tabLabels = _isArabic
        ? const <String>['خيار', 'خيار', 'خيار', 'خيار', 'خيار']
        : const <String>['Option', 'Option', 'Option', 'Option', 'Option'];
    final String buttonLabel = _isArabic ? 'زر' : 'Button';
    final String modalTitle = _isArabic ? 'إنشاء مشروع' : 'Create project';
    final String modalDescription = _isArabic
        ? 'ابدأ بتنظيم عملك من خلال إنشاء مشروع جديد.'
        : 'Start organizing your work by creating a new project.';
    final String cancelLabel = _isArabic ? 'إلغاء' : 'Cancel';
    final String confirmLabel = _isArabic ? 'تأكيد' : 'Confirm';
    final String drawerBody = _isArabic
        ? 'هذا هو مثال لنص يمكن أن يستبدل في نفس المساحة.'
        : 'Lorem ipsum dolor sit amet consectetur adipiscing elit.';

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: AppSegmentedTabs(
              labels: const <String>['EN', 'AR'],
              selectedIndex: _isArabic ? 1 : 0,
              onChanged: (int i) => setState(() => _isArabic = i == 1),
            ),
          ),
          SizedBox(height: 20.h),
          Directionality(
            textDirection: direction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Tabs', style: sectionStyle),
                SizedBox(height: 12.h),
                AppSegmentedTabs(
                  labels: tabLabels,
                  selectedIndex: _segmentedIndex,
                  onChanged: (int i) => setState(() => _segmentedIndex = i),
                ),
                SizedBox(height: 16.h),
                AppUnderlineTabs(
                  labels: tabLabels,
                  selectedIndex: _underlineIndex,
                  onChanged: (int i) => setState(() => _underlineIndex = i),
                ),
                SizedBox(height: 16.h),
                AppUnderlineTabs(
                  labels: tabLabels,
                  selectedIndex: _underlineCompactIndex,
                  onChanged: (int i) =>
                      setState(() => _underlineCompactIndex = i),
                  size: AppUnderlineTabsSize.compact,
                ),
                SizedBox(height: 32.h),
                Text('Buttons', style: sectionStyle),
                SizedBox(height: 12.h),
                for (final AppButtonVariant variant
                    in _buttonVariants) ...<Widget>[
                  Text(variant.name, style: subStyle),
                  SizedBox(height: 8.h),
                  for (final AppButtonSize size in _buttonSizes) ...<Widget>[
                    CustomButton(
                      buttonName: buttonLabel,
                      variant: variant,
                      size: size,
                      isFullWidth: false,
                      onTap: () {},
                    ),
                    SizedBox(height: 8.h),
                  ],
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 16.h),
                Text('Modal', style: sectionStyle),
                SizedBox(height: 12.h),
                CustomButton(
                  buttonName: _isArabic ? 'فتح النافذة' : 'Open modal',
                  isFullWidth: false,
                  onTap: () => AppModal.show<void>(
                    context: context,
                    title: modalTitle,
                    description: modalDescription,
                    cancelLabel: cancelLabel,
                    confirmLabel: confirmLabel,
                    onConfirm: () => Navigator.of(context).pop(),
                    onCancel: () => Navigator.of(context).pop(),
                    onClose: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height: 16.h),
                AppModal(
                  title: modalTitle,
                  description: modalDescription,
                  cancelLabel: cancelLabel,
                  confirmLabel: confirmLabel,
                  onConfirm: () {},
                  onCancel: () {},
                  onClose: () {},
                ),
                SizedBox(height: 32.h),
                Text('Drawer', style: sectionStyle),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: <Widget>[
                    for (final AppDrawerPlacement placement
                        in _drawerPlacements)
                      CustomButton(
                        buttonName: _drawerLabel(placement),
                        variant: AppButtonVariant.outline,
                        isFullWidth: false,
                        onTap: () => _openDrawer(
                          placement,
                          drawerBody,
                          cancelLabel,
                          confirmLabel,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _drawerLabel(AppDrawerPlacement placement) {
    if (_isArabic) {
      return switch (placement) {
        AppDrawerPlacement.top => 'درج علوي',
        AppDrawerPlacement.bottom => 'درج سفلي',
        AppDrawerPlacement.left => 'درج يسار',
        AppDrawerPlacement.right => 'درج يمين',
      };
    }
    return switch (placement) {
      AppDrawerPlacement.top => 'Top drawer',
      AppDrawerPlacement.bottom => 'Bottom drawer',
      AppDrawerPlacement.left => 'Left drawer',
      AppDrawerPlacement.right => 'Right drawer',
    };
  }

  void _openDrawer(
    AppDrawerPlacement placement,
    String body,
    String cancelLabel,
    String confirmLabel,
  ) {
    final bool isArabic = _isArabic;
    AppDrawer.show<void>(
      context: context,
      placement: placement,
      builder: (BuildContext context) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AppDrawer(
          placement: placement,
          title: _drawerLabel(placement),
          body: body,
          cancelLabel: cancelLabel,
          confirmLabel: confirmLabel,
          height:
              placement == AppDrawerPlacement.left ||
                  placement == AppDrawerPlacement.right
              ? double.infinity
              : null,
          onConfirm: () => Navigator.of(context).pop(),
          onCancel: () => Navigator.of(context).pop(),
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
