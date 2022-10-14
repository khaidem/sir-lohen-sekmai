import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBlocListenerWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: LoginFormView(),
        ),
      ),
    );
  }
}
