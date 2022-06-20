// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/app_colors.dart';
import 'package:flutter_demo_auth/app/theme/text_styles.dart';

class DefaultButton extends StatelessWidget {
  final String? label;
  final Widget? body;
  final Color backgroundColor;
  final Color? borderColor;
  final Function()? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final bool withBorder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? innerPadding;

  const DefaultButton({
    Key? key,
    this.label,
    required this.backgroundColor,
    this.borderColor,
    required this.onPressed,
    this.borderRadius,
    this.withBorder = false,
    this.body,
    this.padding,
    this.innerPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // padding: padding ?? EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: padding ?? EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: withBorder
              ? Border.all(
                  width: 2,
                  color: borderColor ?? AppColors.white.withOpacity(.5),
                )
              : null,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
        constraints: const BoxConstraints(
          maxWidth: 500.0,
        ),
        child: Padding(
          padding: innerPadding ?? const EdgeInsets.all(16.0),
          child: Center(
            child: body ??
                Text(
                  label ?? '',
                  style: AppTextStyle.comforta14W400,
                ),
          ),
        ),
      ),
    );
  }
}
