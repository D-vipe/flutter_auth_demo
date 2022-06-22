import 'package:flutter/material.dart';
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';

class GoBackToLogin extends StatelessWidget {
  const GoBackToLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppDictionary.hasAccount,
                style:
                    AppTextStyle.comforta14W400.apply(color: AppColors.white)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.home,
                  (_) => false,
                );
              },
              child: Text(' ${AppDictionary.authorize}',
                  style: AppTextStyle.comforta14W600
                      .apply(color: AppColors.blueGreat)),
            )
          ],
        ));
  }
}
