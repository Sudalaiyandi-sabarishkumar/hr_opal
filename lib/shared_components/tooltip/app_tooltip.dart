import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';

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

class _TooltipAnchor {
  const _TooltipAnchor(this.targetAnchor, this.followerAnchor, this.offset);

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
}

double _crossAxisFor(AppTooltipAlign align) => switch (align) {
  AppTooltipAlign.start => -1,
  AppTooltipAlign.center => 0,
  AppTooltipAlign.end => 1,
};

_TooltipAnchor _resolveAnchor(
  AppTooltipPlacement placement,
  AppTooltipAlign align,
  TextDirection textDirection,
) {
  final double gap = 8.r;
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

  return switch (placement) {
    AppTooltipPlacement.top => _TooltipAnchor(
      Alignment(_crossAxisFor(resolvedAlign), -1),
      Alignment(_crossAxisFor(resolvedAlign), 1),
      Offset(0, -gap),
    ),
    AppTooltipPlacement.bottom => _TooltipAnchor(
      Alignment(_crossAxisFor(resolvedAlign), 1),
      Alignment(_crossAxisFor(resolvedAlign), -1),
      Offset(0, gap),
    ),
    AppTooltipPlacement.left => _TooltipAnchor(
      Alignment(-1, _crossAxisFor(resolvedAlign)),
      Alignment(1, _crossAxisFor(resolvedAlign)),
      Offset(-gap, 0),
    ),
    AppTooltipPlacement.right => _TooltipAnchor(
      Alignment(1, _crossAxisFor(resolvedAlign)),
      Alignment(-1, _crossAxisFor(resolvedAlign)),
      Offset(gap, 0),
    ),
  };
}

/// Wraps [child] so a long press reveals an [AppTooltip]-styled bubble next to
/// it, positioned with a [CompositedTransformFollower] so — unlike Flutter's
/// built-in [Tooltip], which only ever shows above or below its target — all
/// four [AppTooltipPlacement]s (including [AppTooltipPlacement.left] /
/// [AppTooltipPlacement.right]) actually render on the requested side.
///
/// [surface] and [textDirection] default to the ambient [Theme] brightness and
/// [Directionality] — pass them explicitly only to override what the tooltip
/// would otherwise pick up on its own, mirroring how [AppToast] resolves its
/// surface/language.
class AppTooltipTrigger extends StatefulWidget {
  const AppTooltipTrigger({
    super.key,
    required this.message,
    required this.child,
    this.placement = AppTooltipPlacement.top,
    this.align = AppTooltipAlign.center,
    this.surface,
    this.textDirection,
    this.showDuration = const Duration(seconds: 2),
  });

  final String message;
  final Widget child;
  final AppTooltipPlacement placement;
  final AppTooltipAlign align;
  final AppTooltipSurface? surface;
  final TextDirection? textDirection;
  final Duration showDuration;

  @override
  State<AppTooltipTrigger> createState() => _AppTooltipTriggerState();
}

class _AppTooltipTriggerState extends State<AppTooltipTrigger> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _show() {
    if (_entry != null) {
      return;
    }
    final AppTooltipSurface resolvedSurface =
        widget.surface ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppTooltipSurface.dark
            : AppTooltipSurface.light);
    final TextDirection resolvedDirection =
        widget.textDirection ?? Directionality.of(context);
    final _TooltipAnchor anchor = _resolveAnchor(
      widget.placement,
      widget.align,
      resolvedDirection,
    );

    final OverlayState overlay = Overlay.of(context);
    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        left: 0,
        top: 0,
        child: CompositedTransformFollower(
          link: _link,
          showWhenUnlinked: false,
          targetAnchor: anchor.targetAnchor,
          followerAnchor: anchor.followerAnchor,
          offset: anchor.offset,
          child: Material(
            color: AppColors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 150),
              builder: (BuildContext context, double value, Widget? child) =>
                  Opacity(opacity: value, child: child),
              child: Directionality(
                textDirection: resolvedDirection,
                child: AppTooltip(
                  message: widget.message,
                  placement: widget.placement,
                  align: widget.align,
                  surface: resolvedSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _entry = entry;
    Future<void>.delayed(widget.showDuration, _hide);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onLongPress: _show,
        child: Semantics(tooltip: widget.message, child: widget.child),
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
