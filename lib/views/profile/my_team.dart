import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../shared_components/gradient_header/app_gradient_header_scaffold.dart';



class TeamPerson {
  const TeamPerson({
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  final String name;
  final String role;
  final String imageUrl;
}

class MyTeamScreen extends StatelessWidget {
  const MyTeamScreen({
    super.key,
    this.name = 'Casey Wellington',
    this.designation = 'Director',
    this.avatarUrl ='https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'
        ,
    this.birthday = '01 Sept 1990',
    this.phone = '(301) 580-7410',
    this.reportingChain = const <TeamPerson>[
      TeamPerson(
        name: 'Jehovah',
        role: 'Director',
        imageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      ),
      TeamPerson(
        name: 'HARSHA',
        role: 'Delivery Head',
        imageUrl:
            'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200',
      ),
      TeamPerson(
        name: 'Sarah',
        role: 'Design',
        imageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
      ),
    ],
    this.reportingLabels = const <String>[
      'NEXT LEVEL MANAGER',
      'REPORTING MANAGER',
      'REPORTING MANAGER',
    ],
    this.myTeam = const <TeamPerson>[
      TeamPerson(
        name: 'Gugan',
        role: 'SDE 1',
        imageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      ),
      TeamPerson(
        name: 'Sam',
        role: 'SDE 1',
        imageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
      ),
      TeamPerson(
        name: 'Sarah',
        role: 'SDE 1',
        imageUrl:
            'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200',
      ),
      TeamPerson(
        name: 'Antony',
        role: 'SDE 1',
        imageUrl:
            'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200',
      ),
    ],
  });

  final String name;
  final String designation;
  final String avatarUrl;
  final String birthday;
  final String phone;
  final List<TeamPerson> reportingChain;
  final List<String> reportingLabels;
  final List<TeamPerson> myTeam;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppGradientHeaderScaffold(
      title: 'My Team',
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Container(
                              width: 72.r,
                              height: 72.r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dark4blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 16,
                                    offset: Offset(0, 8),
                                    spreadRadius: 2,
                                    color: AppColors.avatarShadow,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  avatarUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 2.w,
                              bottom: 2.h,
                              child: Container(
                                width: 14.r,
                                height: 14.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accordionGreenFg,
                                  border:
                                      Border.all(color: AppColors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              name,
                              style: textTheme.geist18Medium.copyWith(
                                color: AppColors.textPrimary,
                                fontFamily: hostGroteskFont
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              designation,
                              style: textTheme.geist13Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: _InfoBlock(
                                icon: AppAssets.profileCake,
                                label: 'Birthday',
                                value: birthday,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40.h,
                              color: AppColors.neutral200,
                              margin: EdgeInsets.symmetric(horizontal: 12.w),
                            ),
                            Expanded(
                              child: _InfoBlock(
                                icon: AppAssets.profileRing,
                                label: 'Phone',
                                value: phone,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const Divider(color: AppColors.neutral200, height: 1),
                        SizedBox(height: 24.h),


                        Text(
                          'Reporting to',
                          style: textTheme.geist14SemiBold.copyWith(
                            color: AppColors.textPrimary,
                            fontFamily: hostGroteskFont
                          ),
                        ),
                        SizedBox(height: 16.h),
                        for (int i = 0; i < reportingChain.length; i++) ...<Widget>[
                          _ManagerNode(
                            label: reportingLabels.length > i
                                ? reportingLabels[i]
                                : 'REPORTING MANAGER',
                            person: reportingChain[i],
                          ),
                          if (i != reportingChain.length - 1)
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.r,
                                top: 4.h,
                                bottom: 4.h,
                              ),
                              child: SvgPicture.asset(AppAssets.profileUpArrow,height:35.h ,),
                            ),
                        ],
                        SizedBox(height: 15.h),


                        Text(
                          'My Team',
                          style: textTheme.geist14Medium.copyWith(
                            color: AppColors.textPrimary,
                            fontFamily: hostGroteskFont
                          ),
                        ),
                        SizedBox(height: 16.h),
                        for (final TeamPerson person in myTeam)
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _TeamMemberTile(person: person),
                          ),
                      ],
                    ),
      ),
    );
  }
}


class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (icon==AppAssets.profileRing) SvgPicture.asset(icon,height: 11.h, width: 11.w,) else SvgPicture.asset(icon,height: 14.h, width: 14.w,),
            SizedBox(width: 6.w),
            Text(
              label,
              style: textTheme.geist13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: textTheme.geist14Medium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}



class _ManagerNode extends StatelessWidget {
  const _ManagerNode({required this.label, required this.person});

  final String label;
  final TeamPerson person;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        ClipOval(
          child: Image.network(
            person.imageUrl,
            width: 40.r,
            height: 40.r,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: textTheme.geist12Regular.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: <Widget>[
                Text(
                  person.name,
                  style: textTheme.geist14Regular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  ' \u00b7 ${person.role}',
                  style: textTheme.geist13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


class _TeamMemberTile extends StatelessWidget {
  const _TeamMemberTile({required this.person});

  final TeamPerson person;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        ClipOval(
          child: Image.network(
            person.imageUrl,
            width: 40.r,
            height: 40.r,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              person.name,
              style: textTheme.geist14Regular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              person.role,
              style: textTheme.geist13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
