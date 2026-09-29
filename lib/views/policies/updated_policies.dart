import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../shared_components/button/custom_button.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import 'policy_model.dart';

class UpdatedPolicyPage extends StatelessWidget {
  const UpdatedPolicyPage({
    super.key,
    required this.policy,
    this.showAcknowledgmentNotice = false,
  });

  final PolicyModel policy;

  /// Shows the "updated policy requires your acknowledgment" card
  /// under the header when true.
  final bool showAcknowledgmentNotice;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'Updated Policy',
      headerBottom: showAcknowledgmentNotice
          ? const PolicyNoticeCard(
              message:
                  'An updated policy requires your acknowledgment. Please review the document before proceeding.',
            )
          : null,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                policy.documentTitle,
                style: textTheme.geist20SemiBold.copyWith(
                  fontFamily: hostGroteskFont,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Created by: ',
                      style: textTheme.geist14Medium.copyWith(
                        fontFamily: hostGroteskFont,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(text: policy.createdBy),
                  ],
                ),
                style: textTheme.geist14Medium.copyWith(
                  fontFamily: hostGroteskFont,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'For any queries regarding this policy, please reach out to us at ${policy.contactEmail}',
                style: textTheme.geist14Regular.copyWith(
                  color: AppColors.statusNeutralText,
                ),
              ),
              for (final PolicySection s in policy.sections) ...<Widget>[
                SizedBox(height: 20.h),
                Text(
                  s.heading,
                  style: textTheme.geist18SemiBold.copyWith(
                    fontFamily: hostGroteskFont,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  s.body,
                  style: textTheme.geist14Regular.copyWith(
                    color: AppColors.statusNeutralText,
                  ),
                ),
              ],
              SizedBox(height: 47.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      borderRadius: 60.r,
                      textStyle: textTheme.geist14Regular,
                      height: 56.h,
                      buttonName: 'Skip',
                      variant: AppButtonVariant.neutral,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      textStyle: textTheme.geist14Regular,
                      height: 56.h,
                      borderRadius: 60.r,
                      buttonName: 'Acknowledge Policy',
                      variant: AppButtonVariant.secondary,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Notice card shown in the gradient area under the header.
class PolicyNoticeCard extends StatelessWidget {
  const PolicyNoticeCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final BorderRadius radius = BorderRadius.circular(16.r);

    return CustomPaint(
      foregroundPainter: _GradientBorderPainter(
        borderRadius: radius,
        strokeWidth: 0.4,
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // CSS: #FFFFFF 1.7%, #BCC7E4 86.79%, #FFFFFF 151.79%
          // The last stop is beyond 100%, so it's replaced with the
          // interpolated colour at 100% (~#CAD2E9).
          colors: <Color>[
            Color(0xFFFFFFFF),
            Color(0xFFBCC7E4),
            Color(0xFFCAD2E9),
          ],
          stops: <double>[0.017, 0.8679, 1.0],
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0x80FFFFFF), // #FFFFFF80
          borderRadius: radius,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x14FFFFFF), // #FFFFFF14
              offset: Offset(0, 3),
              blurRadius: 4.8,
            ),
          ],
        ),
        child: Text(
          message,
          style: textTheme.geist12Regular.copyWith(
            color: AppColors.statusNeutralText,
          ),
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  _GradientBorderPainter({
    required this.borderRadius,
    required this.strokeWidth,
    required this.gradient,
  });

  final BorderRadius borderRadius;
  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    // Deflate by half the stroke so the border stays inside the bounds.
    final RRect rrect = borderRadius
        .toRRect(rect)
        .deflate(strokeWidth / 2);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter old) =>
      old.borderRadius != borderRadius ||
      old.strokeWidth != strokeWidth ||
      old.gradient != gradient;
}