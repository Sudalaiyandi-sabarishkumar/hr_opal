import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class AppTextArea extends StatelessWidget {
  const AppTextArea({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 4,
    this.isRequired = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: label,
            style: textTheme.geist13Regular.copyWith(
              color: AppColors.toastMessage,
            ),
            children: isRequired
                ? <InlineSpan>[
                    TextSpan(
                      text: ' *',
                      style: textTheme.geist13Regular.copyWith(
                        color: AppColors.statusDanger,
                      ),
                    ),
                  ]
                : null,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.neutral25,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            minLines: maxLines,
            maxLines: maxLines,
            style: textTheme.geist16Regular,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: hint,
              hintStyle: textTheme.geist16Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
