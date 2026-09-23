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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSignInTap() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
  
    context.goNamed(
      RouteConstants.otpPage,
      extra: <String, dynamic>{
        'email': _emailController.text,
        'on_verify': (String pin) {
          if (pin == '123456') {
            GoRouterInit.router.goNamed(RouteConstants.changePasswordPage);
          } else {
            final BuildContext? activeContext = GoRouterInit.navigatorKey.currentContext;
            if (activeContext != null) {
              ScaffoldMessenger.of(activeContext).showSnackBar(
                const SnackBar(content: Text('Invalid OTP. Please try again.')),
              );
            }
          }
        },
      },
    );
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
      
          left: false,
          right: false,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  SizedBox(height: 100.h),
                  Text(
                    'Forgot Password',
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
                          validator: (String? value) =>
                              FormValidationHelper.emailValidator(value),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                child: Row(
            
                  children: <Widget>[
                    Expanded(
                      child: CustomButton(
                        textStyle: textTheme.geist14Regular,
                        buttonName: 'Back',
                        size: AppButtonSize.large,
                        variant: AppButtonVariant.subtle,
                        borderRadius: 60.r,
                        height: 56.h,
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.goNamed(RouteConstants.signInPage);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(
                        textStyle: textTheme.geist14Regular,
                        buttonName: 'Send OTP',
                        size: AppButtonSize.large,
                        variant: AppButtonVariant.secondary,
                        borderRadius: 60.r,
                        height: 56.h,
                        onTap: _onSignInTap,
                      ),
                    ),
                  ],
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
