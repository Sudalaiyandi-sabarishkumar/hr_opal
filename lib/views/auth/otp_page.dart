import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../app_router.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/enums.dart';
import '../../global_widgets/background.dart';
import '../../shared_components/button/custom_button.dart';
import '../../shared_components/toast/app_toast.dart';

typedef OtpVerificationCallback = FutureOr<bool> Function(String pin);

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    this.maskedMobileNumber = '966*******56',
    this.email = '',
    this.otpLength = 6,
    this.resendSeconds = 277,
    this.onVerify,
    this.onResend,
  });

  final String maskedMobileNumber;
  final String email;
  final int otpLength;
  final int resendSeconds;
  final OtpVerificationCallback? onVerify;
  final VoidCallback? onResend;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  late int _secondsRemaining = widget.resendSeconds;
  Timer? _timer;
  bool _hasVerificationError = false;

  // otp_page.dart
Future<void> _verifyPin(String pin) async {
  final bool isValid = await widget.onVerify?.call(pin) ?? true;

  if (!mounted) {
    return;
  }

  setState(() => _hasVerificationError = !isValid);

  if (!isValid) {
    AppToast.show(
      context, // OtpPage's own context — a real descendant of the Overlay
      title: 'Error',
      description: 'Invalid OTP. Please try again.',
      status: AppToastStatus.danger,
    );
  }
  else{
     GoRouterInit.router.goNamed(RouteConstants.changePasswordPage);
  }
}

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = widget.resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remaining = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remaining.toString().padLeft(2, '0')}';
  }

  void _onResendTap() {
    if (_secondsRemaining > 0) {
      return;
    }
    _pinController.clear();
    _pinFocusNode.requestFocus();
    widget.onResend?.call();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final PinTheme defaultPinTheme = PinTheme(
      width: 51.w,
      height: 50.h,
      textStyle: textTheme.geist18Regular.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.textFieldCardBackground,
        borderRadius: BorderRadius.circular(14.r),

        border: Border.all(color: AppColors.textFieldBorderMid, width: 0.4.w),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.textFieldCardShadow,
            offset: Offset(0, 3.h),
            blurRadius: 4.8.r,
          ),
        ],
      ),
    );

    final PinTheme focusedPinTheme = defaultPinTheme.copyWith(
      
      decoration: BoxDecoration(
        color: AppColors.textFieldCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.textFieldBorderMid, width: 0.4.w),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.focusRing.withValues(alpha: 0.35),
            offset: Offset(0, 3.h),
            blurRadius: 8.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
    );

    final PinTheme errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.textFieldCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.statusDanger, width: 0.7.w),
        
      ),
    );

    return Background(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(bottom: 100.h),
            child: Center(
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
                    'Verify OTP',
                    textAlign: TextAlign.center,
                    style: textTheme.geist30Bold.copyWith(
                      fontFamily: hostGroteskFont,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Enter the 6-digit code sent to ',
                      style: textTheme.geist12Regular.copyWith(
                        color: AppColors.white,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.email == ''
                              ? widget.maskedMobileNumber
                              : widget.email,
                          style: textTheme.geist12SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Pinput(
                      length: widget.otpLength,
                      controller: _pinController,
                      focusNode: _pinFocusNode,
                      autofocus: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: defaultPinTheme,
                      errorPinTheme: errorPinTheme,
                      forceErrorState: _hasVerificationError,
                      separatorBuilder: (int index) => SizedBox(width: 8.w),
                      onChanged: (String value) {
                        if (_hasVerificationError) {
                          setState(() => _hasVerificationError = false);
                        }
                        setState(() {});
                      },
                      onCompleted: _verifyPin,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: GestureDetector(
                        onTap: _onResendTap,
                        child: _secondsRemaining > 0
                            ? RichText(
                                text: TextSpan(
                                  text: 'Resend OTP in ',
                                  style: textTheme.geist12Regular,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: _formatTime(_secondsRemaining),
                                      style: textTheme.geist12SemiBold,
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                'Resend OTP',
                                style: textTheme.geist12SemiBold,
                              ),
                      ),
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
            buttonName: 'Verify Code',
            size: AppButtonSize.large,
            variant: AppButtonVariant.secondary,
            borderRadius: 60.r,
            height: 56.h,
            isDisabled: _pinController.text.length != widget.otpLength,
            onTap: () => _verifyPin(_pinController.text),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
