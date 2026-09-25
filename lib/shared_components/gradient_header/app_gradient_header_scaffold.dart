import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

/// The two gradient looks used behind the fixed header across the
/// profile screens. Add more cases here if a new look is introduced
/// instead of hard-coding gradients again in a screen file.
enum AppHeaderGradient { peach, lavender }

/// A screen scaffold with a **fixed** gradient header — back arrow +
/// title — and a scrollable [body] below it.
///
/// The gradient, back arrow and title never move while [body] scrolls,
/// so pass a scrollable widget (`ListView`, `GridView`,
/// `SingleChildScrollView`, or a `Column` with an inner `Expanded`
/// scrollable) as [body]. Used by every profile sub-screen except
/// [ProfileScreen], which has its own hero-style header.
class AppGradientHeaderScaffold extends StatelessWidget {
  const AppGradientHeaderScaffold({
    super.key,
    required this.title,
    required this.body,
    this.gradient = AppHeaderGradient.peach,
    this.headerHeight = 180,
    this.titleColor,
    this.titleStyle,
    this.backButtonHasBorder = false,
    this.onBack,
    this.scaffoldBackgroundColor = AppColors.white,
    this.bodyBackgroundColor = AppColors.white,
    this.bodyBorderRadius = 24,
    this.topSpacing = 39,
    this.titleBottomSpacing = 20,
  });

  /// Title shown centered in the fixed header.
  final String title;

  /// The scrollable content shown below the fixed header. This is what
  /// moves when the user scrolls — the header itself never does.
  final Widget body;

  /// Which gradient look to paint behind the header.
  final AppHeaderGradient gradient;

  /// Height of the gradient area (logical pixels, scaled with `.h`).
  final double headerHeight;

  /// Overrides the title's color. Defaults to [AppColors.textPrimary].
  final Color? titleColor;

  /// Overrides the title's whole text style. Takes precedence over
  /// [titleColor] when provided.
  final TextStyle? titleStyle;

  /// Whether the circular back button gets a hairline border, matching
  /// screens whose gradient runs light-to-light near the top edge.
  final bool backButtonHasBorder;

  /// Called when the back button is tapped. Defaults to popping the
  /// current route via GoRouter.
  final VoidCallback? onBack;

  final Color scaffoldBackgroundColor;

  /// Background of the rounded container [body] sits in. Set this to
  /// `Colors.transparent` for screens (like Personal Information) whose
  /// body paints its own card lower down, leaving gradient visible above it.
  final Color bodyBackgroundColor;

  final double bodyBorderRadius;

  /// Space between the safe area top and the title.
  final double topSpacing;

  /// Space between the title and the body below it.
  final double titleBottomSpacing;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight.h,
            child: _GradientBackground(style: gradient),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                SizedBox(height: topSpacing.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle ??
                          textTheme.geist18SemiBold.copyWith(
                            color: titleColor ?? AppColors.textPrimary,
                            fontFamily: hostGroteskFont,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: titleBottomSpacing.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: bodyBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(bodyBorderRadius.r),
                        topRight: Radius.circular(bodyBorderRadius.r),
                      ),
                    ),
                    child: body,
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, top: topSpacing.h-5.h),
              child: _BackButton(
                hasBorder: backButtonHasBorder,
                onTap: onBack ??
                    () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground({required this.style});

  final AppHeaderGradient style;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case AppHeaderGradient.peach:
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.06, -1.0),
                    end: Alignment(0.06, 1.0),
                    colors: <Color>[
                      AppColors.white,
                      AppColors.headerGradientPeach,
                      AppColors.headerGradientPeach,
                    ],
                    stops: <double>[0.1186, 0.2587, 1.0],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.32, -1.5),
                    radius: 0.9,
                    colors: <Color>[
                      AppColors.headerRadialPurple,
                      AppColors.headerRadialPurpleTransparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case AppHeaderGradient.lavender:
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      AppColors.headerGradientLavenderTop,
                      AppColors.headerGradientLavenderMid,
                      AppColors.headerGradientLavenderBottom,
                    ],
                    stops: <double>[0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(1.0, 1.1),
                    radius: 0.7,
                    colors: <Color>[
                      AppColors.headerGlowPeach,
                      AppColors.headerGlowPeachTransparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.hasBorder, required this.onTap});

  final bool hasBorder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: hasBorder ? Border.all(color: AppColors.chipBorder) : null,
        ),
        child: Icon(
          Icons.chevron_left_rounded,
          size: 22.r,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
