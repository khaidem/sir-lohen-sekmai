import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/auth/logic/login/login_cubit.dart';
import 'package:snp_garbage_collection/src/core/logic/authentication/authentication_cubit.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';

class AuthBlocListenerWrapper extends StatelessWidget {
  const AuthBlocListenerWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: _authenticationCubitListener,
        ),
      ],
      child: child,
    );
  }

  void _authenticationCubitListener(
    BuildContext context,
    LoginState state,
  ) {
    final status = state.status;

    switch (status) {
      case LoginStatus.initial:
        break;
      case LoginStatus.loginInProgress:
        showHUD(title: 'Authenticating..');
        final token = state.token!;
        context.read<AuthenticationCubit>().login(token: token);
        break;
      case LoginStatus.loginSuccessful:
        showSuccessHUD(title: "Login successfully");
        context.read<AuthenticationCubit>().login(token: state.token!);
        break;
      case LoginStatus.loginFailed:
        final errorMessage = state.errorMessage!;
        showErrorHUD(title: errorMessage);
        break;
    }
  }
}
