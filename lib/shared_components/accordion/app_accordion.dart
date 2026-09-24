import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

/// A single collapsible section with a colored header (icon + label +
/// chevron) and an expandable body. Manages its own expand/collapse state
/// so multiple sections on a page can be expanded independently.
///
/// When expanded, the header keeps only its top corners rounded, a thin
/// divider separates it from the body, and the whole section sits inside
/// one bordered, rounded outer card.
class AppAccordion extends StatefulWidget {
  const AppAccordion({
    super.key,
    required this.title,
    required this.icon,
    required this.headerColor,
    required this.iconColor,
    required this.child,
    this.initiallyExpanded = false,
  });

  /// Section label shown in the header, e.g. "Basic Information".
  final String title;

  /// Leading icon shown before the title.
  final IconData icon;

  /// Background color of the header row (e.g. light purple/green/yellow).
  final Color headerColor;

  /// Color used for the icon and title text in the header.
  final Color iconColor;

  /// Content shown when expanded — typically a column of label/value rows.
  final Widget child;

  /// Whether this section starts expanded.
  final bool initiallyExpanded;

  @override
  State<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends State<AppAccordion> {
  late bool _expanded = widget.initiallyExpanded;

  static const double _radius = 16;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final BorderRadius outerRadius = BorderRadius.circular(_radius.r);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: outerRadius,
        border: Border.all(color: AppColors.neutral200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header — full rounding when collapsed, top-only when expanded
          InkWell(
            onTap: _toggle,
            borderRadius: _expanded
                ? BorderRadius.only(
                    topLeft: Radius.circular(_radius.r),
                    topRight: Radius.circular(_radius.r),
                  )
                : outerRadius,
            child: Container(
              width: double.infinity,
              height: 53.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: widget.headerColor,
                borderRadius: _expanded
                    ? BorderRadius.only(
                        topLeft: Radius.circular(_radius.r),
                        topRight: Radius.circular(_radius.r),
                      )
                    : outerRadius,
              ),
              child: Row(
                children: <Widget>[
                  Icon(widget.icon, size: 18.r, color: AppColors.black),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: textTheme.geist14Regular.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 15.r,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider shown only while expanded, separating header from body
          if (_expanded)
            Divider(height: 1.h, thickness: 1, color: AppColors.neutral200),
          // Body
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _expanded
                ? Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                    child: widget.child,
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}

/// A single label/value row used inside an [AppAccordion]'s body,
/// e.g. "First name" -> "Michael".
class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: textTheme.geist13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: textTheme.geist14Regular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
