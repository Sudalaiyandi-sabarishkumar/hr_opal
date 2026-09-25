import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/accordion/app_accordion.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';


class JobBasicDetail {
  const JobBasicDetail({required this.label, required this.value});

  final String label;
  final String value;
}

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({
    super.key,
    this.details = const <JobBasicDetail>[
      JobBasicDetail(label: 'Title', value: 'Mr.'),
      JobBasicDetail(label: 'First name', value: 'Michael'),
      JobBasicDetail(label: 'Middle name', value: 'James'),
      JobBasicDetail(label: 'Last name', value: 'Anderson'),
      JobBasicDetail(
        label: 'Passport name',
        value: 'Anderson Michael James',
      ),
      JobBasicDetail(label: 'Gender', value: 'Male'),
      JobBasicDetail(label: 'Date of birth', value: '03/15/1990'),
      JobBasicDetail(label: 'Place of birth', value: 'Portland, Oregon'),
      JobBasicDetail(label: 'Marital status', value: 'Married'),
      JobBasicDetail(label: 'Blood group', value: 'O+'),
      JobBasicDetail(label: 'Nationality', value: 'American'),
      JobBasicDetail(label: 'Religion', value: 'Christian'),
    ],
  });

  final List<JobBasicDetail> details;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeaderScaffold(
      title: 'Job Details',
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppAccordion(
              title: 'Job Details',
              icon: Icons.badge_outlined,
              headerColor: AppColors.accordionPurpleBg,
              iconColor: AppColors.accordionPurpleFg,
              initiallyExpanded: true,
              child: Column(
                children: <Widget>[
                  for (final JobBasicDetail detail in details)
                    AppInfoRow(
                      label: detail.label,
                      value: detail.value,
                    ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}