import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../global_widgets/common_button.dart';
import '../global_widgets/form_helper/text_field.dart';
import '../global_widgets/widget_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AuthBloc authBloc;
  late final AppBloc appBloc;

  @override
  void initState() {
    userNameController.text = 'TCRO1';
    passwordController.text = 'Password@123';
    authBloc = BlocProvider.of<AuthBloc>(context);
    appBloc = BlocProvider.of<AppBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      authBloc.stream.listen((AuthState state) => (mounted
          ? onAuthBlocChange(context: context, state: state, appBloc: appBloc)
          : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
          title:
              Text('Flutter BLoC Boiler Plate', style: textTheme.titleLarge)),
      body: SafeArea(
          child: Form(
        key: logInFormKey,
        child: Column(
          children: <Widget>[
            const Spacer(),
            CommonTextField(
                customKey: const Key('username_textfield_key'),
                controller: userNameController,
                labelText: 'User Name',
                validator: Validator.empty_validator),
            getSpace(20.sp, 0),
            CommonTextField(
                customKey: const Key('password_textfield_key'),
                controller: passwordController,
                labelText: 'Password',
                validator: Validator.password_validator),
            const Spacer(),
            const Spacer(),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
        return CommonButton(
          customKey: const Key('login_button_key'),
          onPressed: () {
            if (logInFormKey.currentState?.validate() ?? false) {
              authBloc.add(LoginWithPassword(
                  userNameController.text, passwordController.text));
            }
          },
          text: 'Login',
          isLoading: state is AuthLoading,
          loadingText: 'Logging in...',
        );
      }),
    );
  }
}
