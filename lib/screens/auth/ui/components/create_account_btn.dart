// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.registration,
          (_) => false,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            size: width / 18,
            color: AppColors.white,
          ),
          const SizedBox(width: 14.0),
          Text(
            AppDictionary.register,
            style: AppTextStyle.comforta14W600.apply(
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
