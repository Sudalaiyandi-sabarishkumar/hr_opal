import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../global_widgets/widget_helper.dart';

import '../shared_components/info_card/app_info_card.dart';
import '../shared_components/tabs/app_segmented_tabs.dart';

class FamilyAddressDetailsScreen extends StatefulWidget {
  const FamilyAddressDetailsScreen({super.key});

  @override
  State<FamilyAddressDetailsScreen> createState() =>
      _FamilyAddressDetailsScreenState();
}

class _FamilyAddressDetailsScreenState
    extends State<FamilyAddressDetailsScreen> {
  final List<String> tabLabels = <String>['Family Member', 'Address'];

  int _segmentedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180.h,
            child: Stack(
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
                          Color(0xFF918CF6),
                          Color(0x00918CF6),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 39.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: Text(
                        'Family & Address',
                        style: textTheme.geist18SemiBold.copyWith(
                          color: AppColors.textPrimary,
                          fontFamily: hostGroteskFont,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height - 130.h,
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Wrapped so the tabs size to their content instead
                        // of stretching to the full row width.
                        Align(
                          
                          child: IntrinsicWidth(
                            child: AppSegmentedTabs(
                              labels: tabLabels,
                              selectedIndex: _segmentedIndex,
                              onChanged: (int i) =>
                                  setState(() => _segmentedIndex = i),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (_segmentedIndex == 0)
                          emptyBox()
                        else
                          _buildAddressContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, top: 39.h),
              child: InkWell(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Placeholder family-member info — swap in real fields/data source.
  

  /// Placeholder address info reusing the AppInfoCard/AppStackedInfoRow
  /// pair built for the "Current Address" card.
  Widget _buildAddressContent() {
    return Column(
      children: [
        AppInfoCard(
          title: 'Current Address',
          headerColor: AppColors.accordionPurpleBg,
          child: Builder(
            builder: (BuildContext context) {
              final TextTheme textTheme = Theme.of(context).textTheme;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
                    'United States',
                    style: textTheme.geist14Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Contact details',
                    value: 'Jonathan Doeverington',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Email',
                    value: 'katie63@aol.com',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Phone',
                    value: '(765) 322-1399',
                    icon: Icons.smartphone_outlined,
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 15.h,),
        AppInfoCard(
          title: 'Permanent Address',
          headerColor: AppColors.accordionGreenBg,
          child: Builder(
            builder: (BuildContext context) {
              final TextTheme textTheme = Theme.of(context).textTheme;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
                    'United States',
                    style: textTheme.geist14Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Contact details',
                    value: 'Jonathan Doeverington',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Email',
                    value: 'katie63@aol.com',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Phone',
                    value: '(765) 322-1399',
                    icon: Icons.smartphone_outlined,
                  ),
                ],
              );
            },
          ),
        ),
         SizedBox(height: 15.h,),
        AppInfoCard(
          title: 'Emergency Address',
          headerColor: AppColors.accordionYellowBg,
          child: Builder(
            builder: (BuildContext context) {
              final TextTheme textTheme = Theme.of(context).textTheme;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
                    'United States',
                    style: textTheme.geist14Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Contact details',
                    value: 'Jonathan Doeverington',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Email',
                    value: 'katie63@aol.com',
                  ),
                  SizedBox(height: 16.h),
                  const AppStackedInfoRow(
                    label: 'Phone',
                    value: '(765) 322-1399',
                    icon: Icons.smartphone_outlined,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
