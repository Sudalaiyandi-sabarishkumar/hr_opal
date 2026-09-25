import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
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
          Positioned.fill(
            child: Image.asset(AppAssets.bg5Image, fit: BoxFit.cover),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: topSpacing.h + 22.h + titleBottomSpacing.h,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 56.w),
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style:
                                titleStyle ??
                                textTheme.geist18SemiBold.copyWith(
                                  color: titleColor ?? AppColors.textPrimary,
                                  fontFamily: hostGroteskFont,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: InkWell(
                            onTap:
                                onBack ??
                                () {
                                  if (context.canPop()) {
                                    context.pop();
                                  }
                                },
                            borderRadius: BorderRadius.circular(22.r),
                            child: SizedBox(
                              width: 44.r,
                              height: 44.r,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.profileBackArrow,
                                  width: 34.r,
                                  height: 34.r,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        ],
      ),
    );
  }
}
