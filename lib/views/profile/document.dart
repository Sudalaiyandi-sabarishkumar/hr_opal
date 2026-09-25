import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import 'document_viewer_screen.dart';

class DocumentItem {
  const DocumentItem({
    required this.title,
    required this.updatedOn,
    this.imagePaths = const <String>[],
  });

  final String title;
  final String updatedOn;
  final List<String> imagePaths;
}

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({
    super.key,
    this.onDocumentTap,
    this.documents = const <DocumentItem>[
      DocumentItem(
        title: 'Driving License',
        updatedOn: 'Oct 2025',
        imagePaths: <String>[
          AppAssets.bgImage,
          AppAssets.drivingLicenseBack,
        ],
      ),
      DocumentItem(
        title: 'Passport',
        updatedOn: 'Oct 2025',
        imagePaths: <String>[
          AppAssets.passportFront,
          AppAssets.passportBack,
        ],
      ),
      DocumentItem(
        title: 'Employment ID',
        updatedOn: 'Oct 2025',
        imagePaths: <String>[
          AppAssets.employmentIdFront,
          AppAssets.employmentIdBack,
        ],
      ),
      DocumentItem(
        title: 'Bank Passbook',
        updatedOn: 'Oct 2025',
        imagePaths: <String>[
          AppAssets.bankPassbookFront,
          AppAssets.bankPassbookBack,
        ],
      ),
      DocumentItem(
        title: 'PAN Card',
        updatedOn: 'Oct 2025',
        imagePaths: <String>[
          AppAssets.panCardFront,
          AppAssets.panCardBack,
        ],
      ),
    ],
  });

  final List<DocumentItem> documents;
  final ValueChanged<DocumentItem>? onDocumentTap;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Documents',
      titleColor: AppColors.headerTitleNavy,
      gradient: AppHeaderGradient.lavender,
      backButtonHasBorder: true,
      body: GridView.builder(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
        itemCount: documents.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: 185 / 235,
        ),
        itemBuilder: (BuildContext context, int index) {
          final DocumentItem item = documents[index];
          return DocumentFolderCard(
            title: item.title,
            updatedOn: item.updatedOn,
            onTap: () {
              if (onDocumentTap != null) {
                onDocumentTap!(item);
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => DocumentViewerScreen(
                    title: item.title,
                    imagePaths: item.imagePaths,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DocumentFolderCard extends StatelessWidget {
  const DocumentFolderCard({
    super.key,
    required this.title,
    required this.updatedOn,
    this.onTap,
  });

  final String title;
  final String updatedOn;
  final VoidCallback? onTap;

  static const Color _folderLight = AppColors.folderLight;
  static const Color _folderDark = AppColors.folderDark;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          final double w = c.maxWidth;
          final double h = c.maxHeight;
          final double folderTop = h * 0.485;

          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[AppColors.folderGradientTop, AppColors.folderGradientBottom],
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: AppColors.folderShadow,
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    left: w * 0.24,
                    top: h * 0.2,
                    width: w * 0.62,
                    height: h * 0.5,
                    child: Transform.rotate(
                      angle: 0.07,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.folderPaperBack,
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: AppColors.folderPaperShadowBack,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: w * 0.135,
                    top: h * 0.18,
                    width: w * 0.6,
                    height: h * 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: AppColors.folderPaperShadowFront,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: folderTop,
                    bottom: 0,
                    child: CustomPaint(
                      painter: _FolderPainter(
                        light: _folderLight,
                        dark: _folderDark,
                        radius: 14.r,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: w * 0.12,
                            right: 8.w,
                            bottom: h * 0.085,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.geist14Medium.copyWith(
                                  color: AppColors.folderTitleText,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Updated on - $updatedOn',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.geist10Regular.copyWith(
                                  color: AppColors.folderSubtitleText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FolderPainter extends CustomPainter {
  const _FolderPainter({
    required this.light,
    required this.dark,
    required this.radius,
  });

  final Color light;
  final Color dark;
  final double radius;

  static const double _lip = 4;

  Path _path(Size size, double bottom) {
    final double w = size.width;
    final double r = radius;
    final double tabH = size.height * 0.15;
    final double tabEnd = w * 0.30;
    final double slope = w * 0.13;

    return Path()
      ..moveTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..lineTo(tabEnd, 0)
      ..cubicTo(
        tabEnd + slope * 0.45, 0,
        tabEnd + slope * 0.55, tabH,
        tabEnd + slope, tabH,
      )
      ..lineTo(w - r, tabH)
      ..quadraticBezierTo(w, tabH, w, tabH + r)
      ..lineTo(w, bottom - r)
      ..quadraticBezierTo(w, bottom, w - r, bottom)
      ..lineTo(r, bottom)
      ..quadraticBezierTo(0, bottom, 0, bottom - r)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawPath(_path(size, size.height), Paint()..color = dark);


    final Rect rect = Offset.zero & size;
    canvas.drawPath(
      _path(size, size.height - _lip),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[light, Color.lerp(light, dark, 0.25)!],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _FolderPainter old) =>
      old.light != light || old.dark != dark || old.radius != radius;
}