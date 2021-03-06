// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_demo_auth/screens/auth/ui/login_screen.dart';
import 'package:flutter_demo_auth/screens/init/cubit/init_cubit.dart';
import 'package:flutter_demo_auth/screens/init/view/base_screen.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return const BaseScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
