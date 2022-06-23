// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:flutter_demo_auth/app/config/help_route_arguments.dart';
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/app/constants/app_icons.dart';
import 'package:flutter_demo_auth/app/constants/errors_const.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';
import 'package:flutter_demo_auth/app/uikit/default_button.dart';
import 'package:flutter_demo_auth/app/uikit/loader.dart';
import 'package:flutter_demo_auth/screens/auth/ui/components/login_page_text_field.dart';
import 'package:flutter_demo_auth/screens/registration/bloc/registration_bloc.dart';
import 'package:flutter_demo_auth/screens/registration/repository/registration_repository.dart';
import 'package:flutter_demo_auth/screens/registration/ui/components/back_to_login.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationBloc(repository: RegistrationRepository()),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state.registerSuccess) {
            Navigator.of(context).pushNamed(
              Routes.registrationSuccess,
            );
          }
        },
        child: const RegistrationView(),
      ),
    );
  }
}

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController passwordRepeatController;
  late bool phoneIsEmpty;
  late bool passwordIsEmpty;
  late bool passwordRepeatIsEmpty;
  late bool phoneIsValid;
  late bool passwordIsValid;
  late bool passwordRepeatIsValid;
  late bool obscureText = true;
  late bool obscureTextRepeat = true;
  late Color phoneDividerColor;
  late Color passwordDividerColor;
  late Color passwordRepeatDividerColor;
  late String phoneErrorText = '';
  late String passwordErrorText = '';
  late String passwordRepeatErrorText = '';

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    passwordRepeatController = TextEditingController();
    phoneIsEmpty = true;
    passwordIsEmpty = true;
    passwordRepeatIsEmpty = true;
    phoneIsValid = false;
    passwordIsValid = false;
    passwordRepeatIsValid = false;
    phoneDividerColor = AppColors.blue;
    passwordDividerColor = AppColors.blue;
    passwordRepeatDividerColor = AppColors.blue;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    super.dispose();
  }

  void _validateFields() {
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

      if (passwordRepeatController.text.isNotEmpty) {
        if (passwordController.text.isNotEmpty &&
            passwordRepeatController.text != passwordController.text) {
          passwordRepeatDividerColor = AppColors.errorRed;
          passwordRepeatErrorText = AppDictionary.repeatPassError;
        } else {
          passwordRepeatIsValid = true;
          passwordRepeatDividerColor = AppColors.white;
          passwordRepeatErrorText = '';
        }
      } else {
        passwordRepeatIsEmpty = true;
        passwordRepeatDividerColor = AppColors.blue;
        passwordRepeatErrorText = '';
      }
    });

    context
        .read<RegistrationBloc>()
        .add(PasswordChanged(passwordController.text));

    context
        .read<RegistrationBloc>()
        .add(RepeatPasswordChanged(passwordRepeatController.text));

    context
        .read<RegistrationBloc>()
        .add(PhoneNumberChanged(phoneNumberController.text));
  }

  void _buttonOnPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<RegistrationBloc>().add(
          PasswordChanged(
            passwordController.text,
          ),
        );

    context.read<RegistrationBloc>().add(
          RepeatPasswordChanged(
            passwordRepeatController.text,
          ),
        );

    context.read<RegistrationBloc>().add(
          PhoneNumberChanged(
            phoneNumberController.text,
          ),
        );

    context.read<RegistrationBloc>().add(
          RegisterSubmitted(
            phone: phoneNumberController.text,
            password: passwordController.text,
            passwordRepeat: passwordRepeatController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          phoneIsValid =
              state.errorMessage == ServerErrors.userExists ? false : true;
          passwordIsValid = true;
          passwordRepeatIsValid = true;
          phoneDividerColor = state.errorMessage == ServerErrors.userExists
              ? AppColors.errorRed
              : AppColors.blue;
          passwordDividerColor = AppColors.blue;
          passwordRepeatDividerColor = AppColors.blue;

          // Запушим фейл-экран поверх текущего
          Navigator.of(context).pushNamed(Routes.errorLogin,
              arguments: HelpRouteArguments(errorMessage: state.errorMessage));
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
                          Text(
                            AppDictionary.regTitle.toUpperCase(),
                            style: AppTextStyle.comforta18W700
                                .apply(color: AppColors.markBlue),
                          ),
                          const Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: SizedBox(height: 30.0),
                          ),
                          BlocBuilder<RegistrationBloc, RegistrationState>(
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
                                              _validateFields(),
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
                                              _validateFields(),
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
                                        LoginPageTextField(
                                          iconName: AppIcons.keyIcon,
                                          placeholder:
                                              AppDictionary.repeatPassword,
                                          onChanged: (value) =>
                                              _validateFields(),
                                          controller: passwordRepeatController,
                                          isCorrect: passwordRepeatIsEmpty ||
                                              passwordRepeatIsValid,
                                          dividerColor:
                                              passwordRepeatDividerColor,
                                          errorText: passwordRepeatErrorText,
                                          obscureText: obscureTextRepeat,
                                          isPassword: true,
                                          obscureOnTap: () => setState(
                                            () => obscureTextRepeat =
                                                !obscureTextRepeat,
                                          ),
                                        ),
                                        state.status.isSubmissionFailure
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0),
                                                child: Text(
                                                  state.errorMessage,
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .comforta16W400
                                                      .apply(
                                                          color: AppColors
                                                              .errorRed),
                                                ),
                                              )
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
                                            backgroundColor: phoneIsValid &&
                                                    passwordIsValid &&
                                                    passwordRepeatIsValid
                                                ? AppColors.blue
                                                : AppColors.blue
                                                    .withOpacity(.5),
                                            withBorder: true,
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            body: state.status
                                                    .isSubmissionInProgress
                                                ? const Loader(
                                                    size: 20,
                                                  )
                                                : Text(
                                                    AppDictionary.register,
                                                    style: AppTextStyle
                                                        .comforta14W600
                                                        .apply(
                                                            color: AppColors
                                                                .white),
                                                  ),
                                            onPressed: phoneIsValid &&
                                                    passwordIsValid &&
                                                    passwordRepeatIsValid
                                                ? _buttonOnPressed
                                                : null,
                                          ),
                                        ),
                                        const Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child: SizedBox(height: 30.0),
                                        ),
                                        Container(
                                          height: 1.0,
                                          width: width,
                                          color:
                                              AppColors.white.withOpacity(.1),
                                        ),
                                        const Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child: SizedBox(height: 30.0),
                                        ),
                                        const GoBackToLogin(),
                                        const SizedBox(height: 30.0),
                                      ],
                                    ),
                                    // if (state.status.isSubmissionInProgress)
                                    // const _Loader(),
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
        ),
      ),
    );
  }
}
