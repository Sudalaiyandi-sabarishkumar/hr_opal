import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../global_widgets/background.dart';
import '../../global_widgets/form_helper/form_validation_helper.dart';
import '../../shared_components/input_field/app_text_field.dart';
import '../../shared_components/shared_components.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  late final ValueNotifier<String> _passwordNotifier =
      ValueNotifier<String>(_passwordController.text);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    _passwordNotifier.value = _passwordController.text;
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _passwordNotifier.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void _onSignInTap() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }


  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Stack(
      children: <Widget>[
        
        const Positioned.fill(
          child: Background(child: SizedBox.shrink()),
        ),

        
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 0.5,
            child: SvgPicture.asset(
              AppAssets.bg2Image,
              fit: BoxFit.fill,
            ),
          ),
        ),

        Scaffold(
     
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.transparent,
        body: SafeArea(
   
          left: false,
          right: false,
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
                  SizedBox(height: 100.h),
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: textTheme.geist30Bold.copyWith(
                      fontFamily: hostGroteskFont,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Choose a strong new password for your account.',
                    textAlign: TextAlign.center,
                    style: textTheme.geist12Regular.copyWith(color: AppColors.white),
                  ),

                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputFieldGroup(
                            children: <Widget>[

                              AppTextField(
                                label: 'New Password',
                                hint: 'Enter your new Password',
                                controller: _passwordController,
                                isPassword: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (String? value) =>
                                    FormValidationHelper.passwordValidator(value),
                              ),
                              AppTextField(
                                label: 'Confirm Password',
                                hint: 'Re-Enter new Password',
                                controller: _confirmpasswordController,
                                isPassword: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (String? value) =>
                                    FormValidationHelper.confirmPasswordValidator(
                                  value,
                                  _passwordController.text,
                                ),
                              ),
                            ],
                          )
                  ),
                  SizedBox(height: 24.h),
                  ValueListenableBuilder<String>(
                    valueListenable: _passwordNotifier,
                    builder: (BuildContext context, String password, _) {
            
                      final bool hasStartedTyping = password.isNotEmpty;

                      final bool hasLower = RegExp(r'[a-z]').hasMatch(password);
                      final bool hasUpper = RegExp(r'[A-Z]').hasMatch(password);
                      final bool hasNumber = RegExp(r'[0-9]').hasMatch(password);
                      final bool hasLength = password.length >= 8 && password.length <= 12;
                      final bool hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>\-_]').hasMatch(password);

                      final List<_PasswordCondition> conditions = <_PasswordCondition>[
                        _PasswordCondition(
                          label: 'At least one lowercase letter',
                          isValid: hasLower,
                        ),
                        _PasswordCondition(
                          label: 'At least one uppercase letter',
                          isValid: hasUpper,
                        ),
                        _PasswordCondition(
                          label: 'At least one number',
                          isValid: hasNumber,
                        ),
                        _PasswordCondition(
                          label: 'Min 8 characters and Max 12 characters',
                          isValid: hasLength,
                        ),
                        _PasswordCondition(
                          label: 'At least one special character',
                          isValid: hasSpecial,
                        ),
                      ];

                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: conditions.map((_PasswordCondition condition) {
                  
                            final Color textColor = !hasStartedTyping
                                ? AppColors.black
                                : condition.isValid
                                    ? AppColors.statusSuccess
                                    : AppColors.statusDanger;

                            final String? iconAsset = !hasStartedTyping
                                ? null
                                : condition.isValid
                                    ? AppAssets.successCircle
                                    : AppAssets.errorCircle;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (iconAsset != null) ...<Widget>[
                                    SvgPicture.asset(
                                      iconAsset,
                                      width: 16.r,
                                      height: 16.r,
                                    ),
                                    SizedBox(width: 8.w),
                                  ],
                                  Text(
                                    condition.label,
                                    style: textTheme.geist12Regular.copyWith(
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      );
                    },
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
              child: CustomButton(
                textStyle: textTheme.geist14Regular,
                buttonName: 'Reset Password',
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
    ],
  );
}
}

class _PasswordCondition {
  const _PasswordCondition({
    required this.label,
    required this.isValid,
  });

  final String label;
  final bool isValid;
}
