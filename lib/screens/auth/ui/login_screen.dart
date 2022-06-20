import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/app/constants/app_icons.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';
import 'package:flutter_demo_auth/app/uikit/default_button.dart';
import 'package:flutter_demo_auth/app/uikit/loader.dart';
import 'package:flutter_demo_auth/screens/auth/bloc/login_bloc.dart';
import 'package:flutter_demo_auth/screens/auth/login_repository.dart';
import 'package:flutter_demo_auth/screens/auth/ui/components/login_page_text_field.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repository: LoginRepository()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (_) => false,
            );
          }
        },
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late bool phoneIsEmpty;
  late bool passwordIsEmpty;
  late bool phoneIsValid;
  late bool passwordIsValid;
  late bool obscureText = true;
  late Color phoneDividerColor;
  late Color passwordDividerColor;
  late String phoneErrorText = '';
  late String passwordErrorText = '';

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    phoneIsEmpty = true;
    passwordIsEmpty = true;
    phoneIsValid = false;
    passwordIsValid = false;
    phoneDividerColor = AppColors.blue;
    passwordDividerColor = AppColors.blue;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          phoneIsValid = false;
          passwordIsValid = false;
          phoneDividerColor = AppColors.errorRed;
          passwordDividerColor = AppColors.errorRed;

          // Запушим фейл-экран поверх текущего
          Navigator.of(context).pushNamed(Routes.errorLogin);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.backGround,
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  constraints: const BoxConstraints(maxWidth: 500.0),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: SizedBox(height: 30.0),
                            ),
                            Image.asset(
                              AppIcons.logoIcon,
                              width: width / 3,
                              height: width / 3,
                              color: AppColors.markBlue,
                            ),
                            const Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: SizedBox(height: 30.0),
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status,
                              builder: (context, state) {
                                return Flexible(
                                  flex: 29,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          LoginPageTextField(
                                            iconName: AppIcons.phoneIcon,
                                            placeholder: AppDictionary
                                                .phoneNumberPlaceHolder,
                                            onChanged: (value) =>
                                                _phoneIsValidate(),
                                            controller: phoneNumberController,
                                            isCorrect:
                                                phoneIsEmpty || phoneIsValid,
                                            dividerColor: phoneDividerColor,
                                            errorText: phoneErrorText,
                                            isPhoneNumber: true,
                                          ),
                                          LoginPageTextField(
                                            iconName: AppIcons.keyIcon,
                                            placeholder:
                                                AppDictionary.writePassword,
                                            onChanged: (value) =>
                                                _phoneIsValidate(),
                                            controller: passwordController,
                                            isCorrect: passwordIsEmpty ||
                                                passwordIsValid,
                                            dividerColor: passwordDividerColor,
                                            errorText: passwordErrorText,
                                            obscureText: obscureText,
                                            isPassword: true,
                                            obscureOnTap: () => setState(
                                              () => obscureText = !obscureText,
                                            ),
                                          ),
                                          state.status.isSubmissionFailure
                                              ? _getSubmissionError()
                                              : const Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: SizedBox(height: 10.0),
                                                ),
                                          const Flexible(
                                            flex: 5,
                                            fit: FlexFit.tight,
                                            child: SizedBox(height: 36.0),
                                          ),
                                          SizedBox(
                                            width: width / 2,
                                            child: DefaultButton(
                                              padding: EdgeInsets.zero,
                                              backgroundColor: phoneIsValid &&
                                                      passwordIsValid
                                                  ? AppColors.blue
                                                  : AppColors.blue
                                                      .withOpacity(.5),
                                              withBorder: true,
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              body: Text(
                                                AppDictionary.signIn,
                                                style: AppTextStyle
                                                    .comforta18W700
                                                    .apply(
                                                        color: AppColors.white),
                                              ),
                                              onPressed: phoneIsValid &&
                                                      passwordIsValid
                                                  ? _buttonOnPressed
                                                  : null,
                                            ),
                                          ),
                                          const Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: SizedBox(height: 30.0),
                                          ),
                                        ],
                                      ),
                                      if (state.status.isSubmissionInProgress)
                                        const _Loader(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void _buttonOnPressed() {
    print('button is pressed');
    context.read<LoginBloc>().add(
          LoginPasswordChanged(
            passwordController.text,
          ),
        );

    context.read<LoginBloc>().add(
          LoginPhoneNumberChanged(
            phoneNumberController.text,
          ),
        );

    context.read<LoginBloc>().add(
          LoginSubmitted(
            phoneNumber: phoneNumberController.text,
            password: passwordController.text,
          ),
        );
  }

  Widget _getSubmissionError() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        AppDictionary.incorrectPasswordOrPhoneNumber,
        textAlign: TextAlign.center,
        style: AppTextStyle.comforta16W400.apply(color: AppColors.errorRed),
      ),
    );
  }

  void _phoneIsValidate() {
    setState(() {
      if (phoneNumberController.text.isNotEmpty) {
        phoneIsEmpty = false;
        if (phoneNumberController.text.length != 18) {
          phoneIsValid = false;
          phoneDividerColor = AppColors.errorRed;
          phoneErrorText = AppDictionary.incorrectPhoneNumber;
        } else {
          phoneIsValid = true;
          phoneDividerColor = AppColors.white;
          phoneErrorText = '';
        }
      } else {
        phoneIsEmpty = true;
        phoneDividerColor = AppColors.blue;
        phoneErrorText = '';
      }
      if (passwordController.text.isNotEmpty) {
        passwordIsEmpty = false;
        if (passwordController.text.length < 8) {
          passwordIsValid = false;
          passwordDividerColor = AppColors.errorRed;
          passwordErrorText = AppDictionary.passwordIsTooShort;
        } else {
          passwordIsValid = true;
          passwordDividerColor = AppColors.white;
          passwordErrorText = '';
        }
      } else {
        passwordIsEmpty = true;
        passwordDividerColor = AppColors.blue;
        passwordErrorText = '';
      }
    });

    context
        .read<LoginBloc>()
        .add(LoginPasswordChanged(passwordController.text));

    context
        .read<LoginBloc>()
        .add(LoginPhoneNumberChanged(phoneNumberController.text));
  }
}

class _Loader extends StatelessWidget {
  const _Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // color: AppColors.backGround.withOpacity(.95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Loader(),
          const SizedBox(height: 16.0),
          Text(
            AppDictionary.wait,
            style: AppTextStyle.comforta16W400.apply(color: AppColors.white),
          )
        ],
      ),
    );
  }
}
