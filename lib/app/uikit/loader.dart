// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/app_colors.dart';

class Loader extends StatelessWidget {
  final Color? color;
  final double size;

  const Loader({
    Key? key,
    this.color,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color ?? AppColors.white,
        size: size,
      ),
    );
  }
}
