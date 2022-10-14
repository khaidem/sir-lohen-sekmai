import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:snp_garbage_collection/src/auth/data/type/type.dart';
import 'package:snp_garbage_collection/src/core/constant/constant.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';

import 'login_button.view.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => form,
      builder: (BuildContext context, FormGroup formGroup, Widget? child) {
        return ListView(
          children: [
            Image.asset(
              KImage.logo,
              height: 150,
            ),
            const SizedBox(height: 16),
            const Text(
              appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 21),
            ReactiveTextField(
              formControlName: FieldNames.userName,
              validationMessages: (control) => userValidation,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(height: 1.5),
              keyboardType: TextInputType.name,
              showErrors: _showErrorsWhen,
              decoration: getInputDecoration(
                context: context,
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 8),
            ReactiveTextField(
              obscureText: true,
              formControlName: FieldNames.password,
              validationMessages: (control) => passwordValidation,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(height: 1.5),
              keyboardType: TextInputType.name,
              showErrors: _showErrorsWhen,
              decoration: getInputDecoration(
                context: context,
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 30),
            const LoginButtonView()
          ],
        );
      },
    );
  }

  get userValidation => {
        ValidationMessage.required: "Username must not be empty",
        ValidationMessage.minLength: "Username is too short"
      };
  get passwordValidation => {
        ValidationMessage.required: "Password must not be empty",
        ValidationMessage.minLength: "Password is too short"
      };

  get form => FormGroup(
        {
          FieldNames.userName: FormControl<String>(
            validators: [
              Validators.required,
              Validators.minLength(3),
            ],
            touched: true,
          ),
          FieldNames.password: FormControl<String>(validators: [
            Validators.required,
            Validators.minLength(6),
          ], touched: true),
        },
      );

  InputDecoration getInputDecoration({
    required BuildContext context,
    required String hintText,
  }) {
    return InputDecoration(
      filled: true,
      hintText: hintText,
      hintStyle: context.textTheme.subtitle1,
      border: const OutlineInputBorder(),
    );
  }

  /// This setting will allow to show error only when user
  /// TOUCHED the field, and field is DIRTY and data is INVALID.
  bool _showErrorsWhen(AbstractControl control) {
    return control.invalid && control.touched && control.dirty;
  }
}
