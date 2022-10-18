import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/auth/logic/login/login_cubit.dart';
import 'package:snp_garbage_collection/src/core/helper/helper.dart';
import 'package:snp_garbage_collection/src/core/widgets/widgets.dart';

class LoginButtonView extends StatelessWidget {
  const LoginButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context) as FormGroup;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButtonView(
        enable: form.valid,
        child: const Text('Login'),
        onPressed: () {
          final formData = form.value;

          logger.i(formData);
          context.read<LoginCubit>().login(
                loginDto: LoginDto.fromJson(formData),
              );
        },
      ),
    );
  }
}
