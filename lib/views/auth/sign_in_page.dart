import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

  void _onSignInTap() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    if (_segmentedIndex == 0) {
      if (_segmentedIndex == 0) {
//  AppDrawers.show<void>(
//       context: context,
//       placement: AppDrawerPlacement.bottom,
//       builder: (BuildContext context) => Directionality(
//         textDirection: TextDirection.ltr,
//         child: AppDrawers(
//           placement: AppDrawerPlacement.bottom,
//          title: '3 attempts remaining',
//   body: 'You have 3 password attempts remaining before your account '
//       'is temporarily locked. Please ensure you enter the correct password.',
          
          
//           icon: AppAssets.alertImage,
//           onCancel: () => Navigator.of(context).pop(),
//           onClose: () => Navigator.of(context).pop(),
//         ),
//       ),
//     );
}
    }
    else if (_segmentedIndex == 1) {
     
        context.goNamed(
      RouteConstants.otpPage,
       extra: {
    'maskedMobileNumber': _maskMobileNumber(_mobileController.text),
       }
    );
  }
  }

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
  
              padding: EdgeInsets.only(bottom: 100.h),
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
                    child: _segmentedIndex == 0
                        ? InputFieldGroup(
                            children: <Widget>[
                              AppTextField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                label: 'Email ID',
                                hint: 'Enter your mail ID',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? value) =>
                                    FormValidationHelper.emailValidator(value),
                              ),
                              AppTextField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                label: 'Password',
                                hint: 'Enter Password',
                                controller: _passwordController,
                                isPassword: true,
                                validator: (String? value) =>
                                    FormValidationHelper.passwordValidator(value),
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
  onTap: () => setState(() => _checkboxValue = !(_checkboxValue ?? false)),
  child: Row(
    children: <Widget>[
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
),
                        GestureDetector(
                          onTap: () => context.pushNamed(RouteConstants.forgotPasswordPage),
                          child: Text(
                            'Forgot password?',
                            style: textTheme.geist12Regular.copyWith(color: AppColors.toastMessage),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          offset: isKeyboardOpen ? const Offset(0, 1.2) : Offset.zero,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: isKeyboardOpen ? 0 : 1,
            child: IgnorePointer(
              ignoring: isKeyboardOpen,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: CustomButton(
                  textStyle: textTheme.geist14Regular,
                  buttonName: 'Sign In',
                  size: AppButtonSize.large,
                  variant: AppButtonVariant.secondary,
                  borderRadius: 60.r,
                  height: 56.h,
                  onTap: _onSignInTap,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
