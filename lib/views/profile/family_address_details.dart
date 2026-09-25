import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../global_widgets/widget_helper.dart';

import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';
import '../../shared_components/info_card/app_info_card.dart';
import '../../shared_components/tabs/app_segmented_tabs.dart';

class AddressDetail {
  const AddressDetail({
    required this.title,
    required this.headerColor,
    required this.addressLine,
    required this.contactName,
    required this.email,
    required this.phone,
  });

  final String title;
  final Color headerColor;
  final String addressLine;
  final String contactName;
  final String email;
  final String phone;
}

class FamilyAddressDetailsScreen extends StatefulWidget {
  const FamilyAddressDetailsScreen({
    super.key,
    this.addresses = const <AddressDetail>[
      AddressDetail(
        title: 'Current Address',
        headerColor: AppColors.accordionPurpleBg,
        addressLine:
            '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
            'United States',
        contactName: 'Jonathan Doeverington',
        email: 'katie63@aol.com',
        phone: '(765) 322-1399',
      ),
      AddressDetail(
        title: 'Permanent Address',
        headerColor: AppColors.accordionGreenBg,
        addressLine:
            '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
            'United States',
        contactName: 'Jonathan Doeverington',
        email: 'katie63@aol.com',
        phone: '(765) 322-1399',
      ),
      AddressDetail(
        title: 'Emergency Address',
        headerColor: AppColors.accordionYellowBg,
        addressLine:
            '123 Oak Street, Apartment 4B, Austin, Texas, 877534, '
            'United States',
        contactName: 'Jonathan Doeverington',
        email: 'katie63@aol.com',
        phone: '(765) 322-1399',
      ),
    ],
  });

  final List<AddressDetail> addresses;

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
    return AppGradientHeaderScaffold(
      title: 'Family & Address',
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              child: IntrinsicWidth(
                child: AppSegmentedTabs(
                  labels: tabLabels,
                  selectedIndex: _segmentedIndex,
                  onChanged: (int i) => setState(() => _segmentedIndex = i),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24.h),
                child: _segmentedIndex == 0
                    ? emptyBox()
                    : _buildAddressContent(widget.addresses),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressContent(List<AddressDetail> addresses) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < addresses.length; i++) ...<Widget>[
          if (i != 0) SizedBox(height: 15.h),
          _AddressCard(address: addresses[i]),
        ],
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final AddressDetail address;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppInfoCard(
      title: address.title,
      headerColor: address.headerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            address.addressLine,
            style: textTheme.geist14Regular.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          AppStackedInfoRow(
            label: 'Contact details',
            value: address.contactName,
          ),
          SizedBox(height: 16.h),
          AppStackedInfoRow(
            label: 'Email',
            value: address.email,
          ),
          SizedBox(height: 16.h),
          AppStackedInfoRow(
            label: 'Phone',
            value: address.phone,
            icon: Icons.smartphone_outlined,
          ),
        ],
      ),
    );
  }
}
