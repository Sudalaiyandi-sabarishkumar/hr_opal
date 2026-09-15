import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/shared_components.dart';
import 'badges_chips_controls_page.dart';
import 'tabs_buttons_modal_drawer_page.dart';
import 'toast_tooltip_page.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  int _index = 0;

  static const List<String> _tabs = <String>['Inputs', 'Feedback', 'Display'];

  static const List<Widget> _pages = <Widget>[
    TabsButtonsModalDrawerPage(),
    ToastTooltipPage(),
    BadgesChipsControlsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Design System', style: textTheme.geist18SemiBold),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: AppUnderlineTabs(
              labels: _tabs,
              selectedIndex: _index,
              onChanged: (int i) => setState(() => _index = i),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _index, children: _pages),
    );
  }
}
