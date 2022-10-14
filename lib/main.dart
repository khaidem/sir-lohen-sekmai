import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/bootstrap.dart';
import 'package:snp_garbage_collection/src/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(
    (sharedPreferences, appRouter, objectbox) => App(
      appRouter: appRouter,
      sharedPreferences: sharedPreferences,
      objectbox: objectbox,
    ),
  );
}
