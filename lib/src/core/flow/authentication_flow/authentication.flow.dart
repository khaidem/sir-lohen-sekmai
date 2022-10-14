import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/logic/logic.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class AuthenticationFlow extends StatelessWidget {
  const AuthenticationFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.watch<AuthenticationCubit>().state;

    final status = authenticationState.status;

    return AutoRouter.declarative(
      routes: (context) {
        switch (status) {
          case AuthenticationStatus.authorized:
            return [const MainRoute()];

          case AuthenticationStatus.unauthorized:
            return [const LoginRoute()];
          case AuthenticationStatus.error:
            return [const LoginRoute()];
        }
      },
    );
  }
}
