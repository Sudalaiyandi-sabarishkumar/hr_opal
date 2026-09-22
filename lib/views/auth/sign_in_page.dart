import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../global_widgets/background.dart';
import '../../shared_components/button/custom_button.dart';
import '../../shared_components/input_field/app_text_field.dart';
import '../../shared_components/shared_components.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final List<String> tabLabels = <String>['Email ID', 'Mobile Number'];
  int _segmentedIndex = 0;
  bool? _checkboxValue = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFF7BA7D0),
      body: Background(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 59.h),
                Image.asset(
                  AppAssets.hrOpalLogo,
                  height: 25.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 50.h),
                Text(
                  'Sign in to HR Opal',
                  textAlign: TextAlign.center,
                  style: textTheme.geist30Bold.copyWith(
                    fontFamily: hostGroteskFont,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Enter your credentials to access your account',
                  textAlign: TextAlign.center,
                  style: textTheme.geist12Regular.copyWith(color: AppColors.white),
                ),
                SizedBox(height: 24.h),
                AppSegmentedTabs(
                  labels: tabLabels,
                  selectedIndex: _segmentedIndex,
                  onChanged: (int i) => setState(() => _segmentedIndex = i),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: InputFieldGroup(
                    children: <Widget>[
                      AppTextField(
                        label: 'Email ID',
                        hint: 'Enter your mail ID',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppTextField(
                        label: 'Password',
                        hint: 'Enter Password',
                        controller: _passwordController,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppCheckbox(
                            value: _checkboxValue,
                            onChanged: (bool? v) => setState(() => _checkboxValue = v),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Remember me for 30 days',
                            style: textTheme.geist12Regular.copyWith(color: AppColors.statusNeutralText),
                          ),
                        ],
                      ),
                      Text(
                        'Forgot password?',
                        style: textTheme.geist12Regular.copyWith(color: AppColors.toastMessage),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: CustomButton(
          textStyle: textTheme.geist14Regular,
          buttonName: 'Sign In',
          size: AppButtonSize.large,
          variant: AppButtonVariant.secondary,
          borderRadius: 60.r,
          height: 56.h,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}