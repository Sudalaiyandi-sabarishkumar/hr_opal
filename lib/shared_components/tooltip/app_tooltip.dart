import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

enum AppTooltipPlacement { top, bottom, left, right }

enum AppTooltipAlign { start, center, end }

enum AppTooltipSurface { light, dark }

EdgeInsets _tooltipPadding(AppTooltipPlacement placement) {
  final double tail = 6.r;
  return switch (placement) {
    AppTooltipPlacement.top =>
      EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h + tail),
    AppTooltipPlacement.bottom =>
      EdgeInsets.fromLTRB(12.w, 8.h + tail, 12.w, 8.h),
    AppTooltipPlacement.left =>
      EdgeInsets.fromLTRB(12.w, 8.h, 12.w + tail, 8.h),
    AppTooltipPlacement.right =>
      EdgeInsets.fromLTRB(12.w + tail, 8.h, 12.w, 8.h),
  };
}

ShapeDecoration _tooltipDecoration(
  AppTooltipSurface surface,
  AppTooltipPlacement placement,
  AppTooltipAlign align,
) {
  final bool isLight = surface == AppTooltipSurface.light;
  return ShapeDecoration(
    color: isLight ? AppColors.primary800 : AppColors.white,
    shape: _AppTooltipShape(
      placement: placement,
      align: align,
      radius: 15.r,
      tailLength: 6.r,
      tailWidth: 10.r,
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 8.r,
        offset: Offset(0, 2.h),
      ),
    ],
  );
}

TextStyle _tooltipTextStyle(TextTheme textTheme, AppTooltipSurface surface) {
  final Color color = surface == AppTooltipSurface.light
      ? AppColors.white
      : AppColors.textPrimary;
  return textTheme.geist12Medium.copyWith(color: color);
}

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    this.placement = AppTooltipPlacement.top,
    this.align = AppTooltipAlign.center,
    this.surface = AppTooltipSurface.light,
    this.textDirection,
  });

  final String message;
  final AppTooltipPlacement placement;
  final AppTooltipAlign align;
  final AppTooltipSurface surface;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget bubble = DecoratedBox(
      decoration: _tooltipDecoration(surface, placement, align),
      child: Padding(
        padding: _tooltipPadding(placement),
        child: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _tooltipTextStyle(textTheme, surface),
        ),
      ),
    );

    if (textDirection == null) {
      return bubble;
    }
    return Directionality(textDirection: textDirection!, child: bubble);
  }
}

/// Wraps [child] so a long press reveals an [AppTooltip]-styled bubble next to
/// it, using Flutter's own [Tooltip] overlay (positioning, screen-edge
/// clamping, dismiss-on-tap-elsewhere, and accessibility all come for free).
///
/// [surface] and [textDirection] default to the ambient [Theme] brightness and
/// [Directionality] — pass them explicitly only to override what the tooltip
/// would otherwise pick up on its own, mirroring how [AppToast] resolves its
/// surface/language. Flutter's [Tooltip] only positions itself above or below
/// its target, so [AppTooltipPlacement.left]/[AppTooltipPlacement.right] fall
/// back to [AppTooltipPlacement.top] here.
class AppTooltipTrigger extends StatelessWidget {
  const AppTooltipTrigger({
    super.key,
    required this.message,
    required this.child,
    this.placement = AppTooltipPlacement.top,
    this.align = AppTooltipAlign.center,
    this.surface,
    this.textDirection,
    this.waitDuration = const Duration(milliseconds: 300),
    this.showDuration = const Duration(seconds: 2),
  });

  final String message;
  final Widget child;
  final AppTooltipPlacement placement;
  final AppTooltipAlign align;
  final AppTooltipSurface? surface;
  final TextDirection? textDirection;
  final Duration waitDuration;
  final Duration showDuration;

  @override
  Widget build(BuildContext context) {
    final AppTooltipSurface resolvedSurface =
        surface ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppTooltipSurface.dark
            : AppTooltipSurface.light);
    final TextDirection resolvedDirection =
        textDirection ?? Directionality.of(context);
    final AppTooltipPlacement resolvedPlacement =
        placement == AppTooltipPlacement.bottom
        ? AppTooltipPlacement.bottom
        : AppTooltipPlacement.top;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Directionality(
      textDirection: resolvedDirection,
      child: Tooltip(
        message: message,
        triggerMode: TooltipTriggerMode.longPress,
        preferBelow: resolvedPlacement == AppTooltipPlacement.bottom,
        padding: _tooltipPadding(resolvedPlacement),
        margin: EdgeInsets.zero,
        waitDuration: waitDuration,
        showDuration: showDuration,
        textStyle: _tooltipTextStyle(textTheme, resolvedSurface),
        decoration: _tooltipDecoration(resolvedSurface, resolvedPlacement, align),
        child: child,
      ),
    );
  }
}

class _AppTooltipShape extends ShapeBorder {
  const _AppTooltipShape({
    required this.placement,
    required this.align,
    required this.radius,
    required this.tailLength,
    required this.tailWidth,
  });

  final AppTooltipPlacement placement;
  final AppTooltipAlign align;
  final double radius;
  final double tailLength;
  final double tailWidth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  double _resolve(double start, double end, AppTooltipAlign resolvedAlign) {
    return switch (resolvedAlign) {
      AppTooltipAlign.start => start,
      AppTooltipAlign.center => (start + end) / 2,
      AppTooltipAlign.end => end,
    };
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Rect body = switch (placement) {
      AppTooltipPlacement.top => Rect.fromLTRB(
        rect.left,
        rect.top,
        rect.right,
        rect.bottom - tailLength,
      ),
      AppTooltipPlacement.bottom => Rect.fromLTRB(
        rect.left,
        rect.top + tailLength,
        rect.right,
        rect.bottom,
      ),
      AppTooltipPlacement.left => Rect.fromLTRB(
        rect.left,
        rect.top,
        rect.right - tailLength,
        rect.bottom,
      ),
      AppTooltipPlacement.right => Rect.fromLTRB(
        rect.left + tailLength,
        rect.top,
        rect.right,
        rect.bottom,
      ),
    };

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(body, Radius.circular(radius)));

    final bool isVertical =
        placement == AppTooltipPlacement.top ||
        placement == AppTooltipPlacement.bottom;
    final bool rtl = textDirection == TextDirection.rtl;
    final AppTooltipAlign resolvedAlign = (isVertical && rtl)
        ? switch (align) {
            AppTooltipAlign.start => AppTooltipAlign.end,
            AppTooltipAlign.end => AppTooltipAlign.start,
            AppTooltipAlign.center => AppTooltipAlign.center,
          }
        : align;

    final double axisMargin = radius + tailWidth / 2;

    final double tailX = _resolve(
      body.left + axisMargin,
      body.right - axisMargin,
      resolvedAlign,
    ).clamp(body.left + tailWidth / 2, body.right - tailWidth / 2);
    final double tailY = _resolve(
      body.top + axisMargin,
      body.bottom - axisMargin,
      resolvedAlign,
    ).clamp(body.top + tailWidth / 2, body.bottom - tailWidth / 2);

    switch (placement) {
      case AppTooltipPlacement.top:
        path
          ..moveTo(tailX - tailWidth / 2, body.bottom)
          ..lineTo(tailX, body.bottom + tailLength)
          ..lineTo(tailX + tailWidth / 2, body.bottom)
          ..close();
      case AppTooltipPlacement.bottom:
        path
          ..moveTo(tailX - tailWidth / 2, body.top)
          ..lineTo(tailX, body.top - tailLength)
          ..lineTo(tailX + tailWidth / 2, body.top)
          ..close();
      case AppTooltipPlacement.left:
        path
          ..moveTo(body.right, tailY - tailWidth / 2)
          ..lineTo(body.right + tailLength, tailY)
          ..lineTo(body.right, tailY + tailWidth / 2)
          ..close();
      case AppTooltipPlacement.right:
        path
          ..moveTo(body.left, tailY - tailWidth / 2)
          ..lineTo(body.left - tailLength, tailY)
          ..lineTo(body.left, tailY + tailWidth / 2)
          ..close();
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
