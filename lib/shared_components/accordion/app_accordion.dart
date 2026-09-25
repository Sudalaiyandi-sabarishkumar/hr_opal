import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';


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

  
  final String title;

  
  final String icon;

  
  final Color headerColor;

  
  final Color iconColor;

  
  final Widget child;

  
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
                  SvgPicture.asset(widget.icon,height: 14.h,width: 14.w,),
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
          
          if (_expanded)
            Divider(height: 1.h, thickness: 1, color: AppColors.neutral200),
          
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
