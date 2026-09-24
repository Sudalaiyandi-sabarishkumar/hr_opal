import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({
    super.key,
    required this.title,
    required this.imagePaths,
  });

  final String title;
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.viewerBackground,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 39.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  height: 40.r,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52.w),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.geist18SemiBold.copyWith(
                            color: AppColors.white,
                            fontFamily: hostGroteskFont,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).maybePop(),
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 20.r,
                              color: AppColors.viewerIconColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints c) {
                    final double vPad = 24.h;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: vPad,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: c.maxHeight - vPad * 2,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              for (int i = 0; i < imagePaths.length; i++) ...<Widget>[
                                if (i > 0) SizedBox(height: 16.h),
                                _DocumentPage(path: imagePaths[i]),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentPage extends StatelessWidget {
  const _DocumentPage({required this.path});

  final String path;

  bool get _isNetwork => path.startsWith('http');

  Widget _image({BoxFit fit = BoxFit.cover}) {
    Widget placeholder(BuildContext _, Object __, StackTrace? ___) => Container(
          color: AppColors.viewerPlaceholderBg,
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: AppColors.viewerPlaceholderIcon,
          ),
        );

    return _isNetwork
        ? Image.network(path, fit: fit, errorBuilder: placeholder)
        : Image.asset(path, fit: fit, errorBuilder: placeholder);
  }

  void _openZoom(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.87),
      builder: (BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Center(child: _image(fit: BoxFit.contain)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openZoom(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: AspectRatio(
          aspectRatio: 400 / 256,
          child: _image(),
        ),
      ),
    );
  }
}