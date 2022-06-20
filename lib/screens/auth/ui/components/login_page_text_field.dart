// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_icons.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';
import 'package:flutter_demo_auth/services/text_formatters/phone_formatter.dart';

class LoginPageTextField extends StatelessWidget {
  const LoginPageTextField({
    Key? key,
    required this.iconName,
    required this.placeholder,
    required this.onChanged,
    this.obscureOnTap,
    required this.controller,
    required this.isCorrect,
    required this.dividerColor,
    this.obscureText = false,
    this.isPhoneNumber = false,
    this.isPassword = false,
    required this.errorText,
  }) : super(key: key);

  final String iconName;
  final String placeholder;
  final Function(String) onChanged;
  final Function()? obscureOnTap;
  final TextEditingController controller;
  final bool isCorrect;
  final Color dividerColor;
  final bool obscureText;
  final bool isPhoneNumber;
  final bool isPassword;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints(maxWidth: 500.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconName,
                  width: width / 18,
                  color: isCorrect ? AppColors.markBlue : AppColors.errorRed,
                ),
                Expanded(
                  child: CupertinoTextField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    obscureText: obscureText,
                    decoration: const BoxDecoration(),
                    keyboardType: isPhoneNumber
                        ? TextInputType.number
                        : TextInputType.text,
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    cursorColor: AppColors.blue,
                    style: AppTextStyle.comforta18W400.apply(
                      color: isCorrect ? AppColors.white : AppColors.errorRed,
                    ),
                    placeholder: placeholder,
                    placeholderStyle: AppTextStyle.comforta18W400.apply(
                      color: AppColors.markBlue,
                    ),
                    inputFormatters: isPhoneNumber
                        ? [phoneFormatter(controller.text)]
                        : null,
                    onChanged: onChanged,
                    controller: controller,
                  ),
                ),
                if (isPassword)
                  GestureDetector(
                    onTap: obscureOnTap,
                    child: SvgPicture.asset(
                      AppIcons.showPasswordIcon,
                      width: width / 18,
                      color:
                          obscureText ? AppColors.markBlue : AppColors.errorRed,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: width,
              height: 1.0,
              color: dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
            child: Text(
              errorText,
              style: AppTextStyle.comforta12W400.apply(
                color: AppColors.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
