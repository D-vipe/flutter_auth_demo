// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/screens/auth/ui/error_login_pop.dart';
import 'package:flutter_demo_auth/screens/init/cubit/init_cubit.dart';
import 'package:flutter_demo_auth/screens/init/view/init_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.errorLogin:
        return MaterialPageRoute(builder: (_) => const ErrorLogin());
      case Routes.home:
      default:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => InitCubit(),
              )
            ],
            child: const InitScreen(),
          ),
        );
    }
  }
}
