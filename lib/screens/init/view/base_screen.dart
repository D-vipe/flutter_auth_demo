import 'package:flutter/material.dart';
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/app/constants/app_icons.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';
import 'package:flutter_demo_auth/app/uikit/default_button.dart';
import 'package:flutter_demo_auth/services/shared_preferences.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        title: const Text(AppDictionary.successAppBarTitle),
      ),
      body: Center(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15.0),
                  Image.asset(AppIcons.successImage),
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox(height: 30.0),
                  ),
                  Text(
                    'Поздравляем!',
                    style: AppTextStyle.comforta18W700
                        .apply(color: AppColors.white),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'А теперь вы можете',
                    style: AppTextStyle.comforta14W400
                        .apply(color: AppColors.white),
                  ),
                  const SizedBox(height: 15.0),
                  DefaultButton(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.blue,
                    withBorder: true,
                    borderRadius: BorderRadius.circular(25.0),
                    body: Text(
                      AppDictionary.logOut,
                      style: AppTextStyle.comforta16W400
                          .apply(color: AppColors.white),
                    ),
                    onPressed: () async {
                      await SharedStorageService.clear().then((_) =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.home, (_) => false));
                    },
                  ),
                  const Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: SizedBox(height: 30.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
