import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import 'dummy_pages.dart';
import 'payroll/payroll_screen.dart';



/// ---------------------------------------------------------------------------
/// Asset paths. Move these into your AppAssets class and add the SVGs to
/// pubspec.yaml (assets: - assets/icons/nav/).
/// ---------------------------------------------------------------------------




class _TabItem {
  const _TabItem(this.label, this.asset);
  final String label;
  final String asset;
}

class _MenuItem {
  const _MenuItem(this.label, this.asset, this.builder);
  final String label;
  final String asset;
  final WidgetBuilder builder;
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  bool _menuOpen = false;

  static const List<_TabItem> _tabs = <_TabItem>[
    _TabItem('Home', AppAssets.home),
    _TabItem('Attendance', AppAssets.attendance),
    _TabItem('Payroll', AppAssets.payroll),
  ];

  // Listed top -> bottom, same as the design.
  static final List<_MenuItem> _menuItems = <_MenuItem>[
    _MenuItem('Holiday Calendar', AppAssets.holidayCalendar,
        (_) => const HolidayCalendarPage()),
    _MenuItem('My Leaves', AppAssets.myLeaves, (_) => const MyLeavesPage()),
    _MenuItem('Announcements', AppAssets.announcements,
        (_) => const AnnouncementsPage()),
  ];

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    AttendancePage(),
    PayrollPage()
  ];

  void _toggleMenu() => setState(() => _menuOpen = !_menuOpen);

  void _closeMenu() {
    if (_menuOpen) setState(() => _menuOpen = false);
  }

  void _onTabTap(int i) {
    setState(() {
      _index = i;
      _menuOpen = false;
    });
  }

  void _onMenuItemTap(_MenuItem item) {
    _closeMenu();
    Navigator.of(context).push(MaterialPageRoute<void>(builder: item.builder));
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    final double barBottom = bottomInset + 12.h;
    final double barHeight = 64.h;

    return PopScope(
      canPop: !_menuOpen,
      onPopInvokedWithResult: (bool didPop, Object? _) {
        if (!didPop) _closeMenu();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            // Pages
            Positioned.fill(
              child: IndexedStack(index: _index, children: _pages),
            ),

            // Blurred dark overlay
            Positioned.fill(
              child: IgnorePointer(
                ignoring: !_menuOpen,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _closeMenu,
                  child: AnimatedOpacity(
                    opacity: _menuOpen ? 1 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              AppColors.overlayTop,
                              AppColors.overlayBottom,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Expanded menu items
            Positioned(
              right: 20.w,
              bottom: barBottom + barHeight + 20.h,
              child: IgnorePointer(
                ignoring: !_menuOpen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List<Widget>.generate(_menuItems.length, (int i) {
                    // Item closest to the button appears first.
                    final int order = _menuItems.length - 1 - i;
                    return _AnimatedMenuRow(
                      visible: _menuOpen,
                      delay: Duration(milliseconds: 40 * order),
                      item: _menuItems[i],
                      onTap: () => _onMenuItemTap(_menuItems[i]),
                    );
                  }),
                ),
              ),
            ),

            // Pill tab bar + circular menu button
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: barBottom,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _PillTabBar(
                      height: barHeight,
                      tabs: _tabs,
                      currentIndex: _index,
                      onTap: _onTabTap,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  _MenuFab(
                    size: barHeight,
                    open: _menuOpen,
                    onTap: _toggleMenu,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pill tab bar
// ---------------------------------------------------------------------------
class _PillTabBar extends StatelessWidget {
  const _PillTabBar({
    required this.height,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  final double height;
  final List<_TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
Widget build(BuildContext context) {
  final double borderWidth = 1.5.r; // adjust to match the design
  final double outerRadius = height / 2;
  final double innerRadius = outerRadius - borderWidth;

  return Container(
    height: height,
    padding: EdgeInsets.all(borderWidth),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(outerRadius),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFE4DBFF), // gradient start, replace with your color
          Color(0xFFFFFFFF), // gradient end, replace with your color
        ],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 16.r,
          offset: Offset(0, 4.h),
        ),
      ],
    ),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(innerRadius),
      ),
      child: Row(
        children: List<Widget>.generate(tabs.length, (int i) {
          final bool selected = i == currentIndex;
          final Color color =
              selected ? AppColors.active : AppColors.inactive;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              borderRadius: BorderRadius.circular(innerRadius),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    tabs[i].asset,
                    width: 26.r,
                    height: 26.r,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    tabs[i].label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ),
  );
}
}

// ---------------------------------------------------------------------------
// Circular purple menu button
// ---------------------------------------------------------------------------
class _MenuFab extends StatelessWidget {
  const _MenuFab({
    required this.size,
    required this.open,
    required this.onTap,
  });

  final double size;
  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[AppColors.fabStart, AppColors.fabEnd],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.fabEnd.withOpacity(0.45),
              blurRadius: 16.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> anim) =>
                RotationTransition(
              turns: Tween<double>(begin: 0.85, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: SvgPicture.asset(
              open ? AppAssets.menuClose : AppAssets.menuGrid,
              key: ValueKey<bool>(open),
              width: 24.r,
              height: 24.r,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Menu row: label + translucent circle with image icon
// ---------------------------------------------------------------------------
class _AnimatedMenuRow extends StatelessWidget {
  const _AnimatedMenuRow({
    required this.visible,
    required this.delay,
    required this.item,
    required this.onTap,
  });

  final bool visible;
  final Duration delay;
  final _MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Duration duration = Duration(
      milliseconds: 220 + (visible ? delay.inMilliseconds : 0),
    );
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 0.4),
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: duration,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 14.w),
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.menuCircle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      item.asset,
                      width: 22.r,
                      height: 22.r,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}