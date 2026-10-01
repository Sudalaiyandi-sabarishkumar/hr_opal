import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../global_widgets/background.dart';
import '../../global_widgets/form_helper/form_validation_helper.dart';

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
  bool _credentialError = false;

  static const String _tempEmail = 'admin@example.com';
  static const String _tempPassword = 'Password@123';
  static const String _tempOtp = '123456';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  String _maskMobileNumber(String number) {
    if (number.length <= 5) {
      return number;
    }
    final String start = number.substring(0, 3);
    final String end = number.substring(number.length - 2);
    final String masked = '*' * (number.length - 5);
    return '$start$masked$end';
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _mobileController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() => _credentialError = false);
  }

  bool get _canSignIn {
    if (_segmentedIndex == 0) {
      return _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    }
    return FormValidationHelper.phoneValidator(_mobileController.text) == null;
  }

  void _onSignInTap() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    if (_segmentedIndex == 0) {
      if (_emailController.text != _tempEmail ||
          _passwordController.text != _tempPassword) {
        setState(() => _credentialError = true);
        _formKey.currentState?.validate();
        return;
      }
      context.goNamed(RouteConstants.mainShellPage);
    } else if (_segmentedIndex == 1) {
      context.goNamed(
        RouteConstants.otpPage,
        extra: <String, dynamic>{
          'maskedMobileNumber': _maskMobileNumber(_mobileController.text),
          'on_verify': (String pin) => pin == _tempOtp,
          'success_route': RouteConstants.mainShellPage,
        },
      );
    }
  }

  void _onTermsTap() {}

  void _onPrivacyTap() {}

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Background(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Form(
            key: _formKey,

            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

              padding: EdgeInsets.only(bottom: 140.h),
              child: Column(
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
                    style: textTheme.geist12Regular.copyWith(
                      color: AppColors.white,
                    ),
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
                    child: _segmentedIndex == 0
                        ? InputFieldGroup(
                            children: <Widget>[
                              AppTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: 'Email ID',
                                hint: 'Enter your mail ID',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? value) =>
                                    FormValidationHelper.emailValidator(value),
                              ),
                              AppTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: 'Password',
                                hint: 'Enter Password',
                                controller: _passwordController,
                                isPassword: true,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is mandatory';
                                  }
                                  return _credentialError
                                      ? 'Incorrect email address and/or password'
                                      : null;
                                },
                              ),
                            ],
                          )
                        : InputFieldGroup(
                            children: <Widget>[
                              AppTextField(
                                label: 'Mobile Number',
                                hint: 'Enter your mobile number',
                                controller: _mobileController,
                                numericOnly: true,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,

                                validator: (String? value) =>
                                    FormValidationHelper.phoneValidator(value),
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
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => setState(
                            () => _checkboxValue = !(_checkboxValue ?? false),
                          ),
                          child: Row(
                            children: <Widget>[
                              AppCheckbox(
                                value: _checkboxValue,
                                onChanged: (bool? v) =>
                                    setState(() => _checkboxValue = v),
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                'Remember me for 30 days',
                                style: textTheme.geist12Regular.copyWith(
                                  color: AppColors.statusNeutralText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pushNamed(
                            RouteConstants.forgotPasswordPage,
                          ),
                          child: Text(
                            'Forgot password?',
                            style: textTheme.geist12Regular.copyWith(
                              color: AppColors.toastMessage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            offset: isKeyboardOpen ? const Offset(0, 1.2) : Offset.zero,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isKeyboardOpen ? 0 : 1,
              child: IgnorePointer(
                ignoring: isKeyboardOpen,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 5.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomButton(
                        textStyle: textTheme.geist14Regular,
                        buttonName: 'Sign In',
                        size: AppButtonSize.large,
                        // variant: AppButtonVariant.secondary,
                        isDisabled: !_canSignIn,
                        variant: _canSignIn
                            ? AppButtonVariant.secondary
                            : AppButtonVariant.muted,
                        borderRadius: 60.r,
                        height: 56.h,
                        onTap: _onSignInTap,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: _onTermsTap,
                            child: Text(
                              'Terms & Conditions',
                              style: textTheme.geist10Regular.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Container(
                              width: 3.r,
                              height: 3.r,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _onPrivacyTap,
                            child: Text(
                              'Privacy Policy',
                              style: textTheme.geist10Regular.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
