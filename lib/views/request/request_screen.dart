import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/input_field/app_text_field.dart';
import '../../shared_components/shared_components.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  static const int _columns = 3;

  // Section circle background colors (move into AppColors if you have tokens).
  static const Color _leaveBg = Color(0xFFEEEAFB);
  static const Color _travelBg = Color(0xFFFFF0C2);
  static const Color _loanBg = Color(0xFFDDF5D8);
  static const Color _othersBg = Color(0xFFE8ECF7);

  void _go(String routeName) {
    context.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Raise a Request',
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _RequestSection(
                title: 'LEAVE & ATTENDANCE',
                columns: _columns,
                bgColor: _leaveBg,
                items: <_RequestItemData>[
                  _RequestItemData(
                    'New Leave',
                    AppAssets.requestBeach,
                    onTap: () => _go(RouteConstants.myLeavesPage),
                  ),
                  _RequestItemData(
                    'Resumption',
                    AppAssets.requestCalendarCheckIn,
                    onTap: () {},
                  ),
                  _RequestItemData(
                    'Cancellation',
                    AppAssets.requestCalendarBlock,
                    onTap: () {},
                  ),
                  _RequestItemData(
                    'Regularization',
                    AppAssets.requestMoveTo,
                    onTap: () =>
                        _go(RouteConstants.attendanceRegularizationPage),
                  ),
                  _RequestItemData(
                    'Encashment',
                    AppAssets.requestMoneySendFlow,
                    onTap: () => _go(RouteConstants.encashmentRequestPage),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              _RequestSection(
                title: 'TRAVEL & EXPENSE',
                columns: _columns,
                bgColor: _travelBg,
                items: <_RequestItemData>[
                  _RequestItemData(
                    'New Travel',
                    AppAssets.requestAirplane,
                    onTap: () => _go(RouteConstants.travelRequestPage),
                  ),
                  _RequestItemData(
                    'Settlement',
                    AppAssets.requestMoneyReceive,
                    onTap: () =>
                        _go(RouteConstants.travelSettlementRequestPage),
                  ),
                  _RequestItemData(
                    'Expense',
                    AppAssets.requestInvoice,
                    onTap: () => _go(RouteConstants.expenseRequest),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              _RequestSection(
                title: 'LOAN & DOCUMENTS',
                columns: _columns,
                bgColor: _loanBg,
                items: <_RequestItemData>[
                  _RequestItemData(
                    'New Loan',
                    AppAssets.requestZakat,
                    onTap: () => _go(RouteConstants.loanRequestPage),
                  ),
                  _RequestItemData(
                    'Adjustment',
                    AppAssets.requestFilterVertical,
                    onTap: () {},
                  ),
                  _RequestItemData(
                    'Document',
                    AppAssets.requestDocumentAttachment,
                    onTap: () => _go(RouteConstants.documentRequestPage),
                  ),
                  _RequestItemData(
                    'Passport',
                    AppAssets.requestStudentCard,
                    onTap: () => _go(RouteConstants.passportRequestPage),
                  ),
                  _RequestItemData(
                    'Letter',
                    AppAssets.requestMailOpen,
                    onTap: () => _go(RouteConstants.letterRequestPage),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              _RequestSection(
                title: 'OTHERS',
                columns: _columns,
                bgColor: _othersBg,
                items: <_RequestItemData>[
                  _RequestItemData(
                    'Assets',
                    AppAssets.requestLaptop,
                    onTap: () => _go(RouteConstants.assetRequestPage),
                  ),
                  _RequestItemData(
                    'Tax',
                    AppAssets.requestMoneySecurity,
                    onTap: () => _go(RouteConstants.taxRequestPage),
                  ),
                  _RequestItemData(
                    'Separation',
                    AppAssets.requestLogout,
                    onTap: () {},
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

class _RequestItemData {
  const _RequestItemData(this.label, this.asset, {required this.onTap});

  final String label;
  final String asset;
  final VoidCallback onTap;
}

class _RequestSection extends StatelessWidget {
  const _RequestSection({
    required this.title,
    required this.items,
    required this.columns,
    required this.bgColor,
  });

  final String title;
  final List<_RequestItemData> items;
  final int columns;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < items.length; i += columns) {
      final List<Widget> cells = <Widget>[];
      for (int j = i; j < i + columns; j++) {
        cells.add(
          Expanded(
            child: j < items.length
                ? _RequestTile(
                    data: items[j],
                    bgColor: bgColor,
                    onTap: items[j].onTap,
                  )
                : const SizedBox.shrink(),
          ),
        );
      }
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cells,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textTheme.geist10Medium.copyWith(
            color: AppColors.toastMessage,
            letterSpacing: 1.2,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 20.h),
        ...rows,
      ],
    );
  }
}

class _RequestTile extends StatelessWidget {
  const _RequestTile({
    required this.data,
    required this.bgColor,
    required this.onTap,
  });

  final _RequestItemData data;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              data.asset,
              width: 24.w,
              height: 24.w,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            data.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.geist12Regular.copyWith(
              color: AppColors.statusNeutralText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.hint,
    required this.trailing,
    required this.onTap,
    this.value,
  });

  final String label;
  final String hint;
  final String? value;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final InputFieldGroupType groupType = InputFieldGroupScope.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: label,
                      style: textTheme.geist13Regular.copyWith(
                        color: groupType.labelColor,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' *',
                          style: textTheme.geist13Regular.copyWith(
                            color: AppColors.statusDanger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value ?? hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: value == null
                        ? textTheme.geist16Regular.copyWith(
                            color: groupType.hintColor,
                          )
                        : textTheme.geist16Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}
