import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/core/widgets/widgets.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

import 'src/core/object_box/objectbox.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// all the initial setup required before running the the app add here
Future<void> initSetup() async {
  hudSetup();
}

typedef BuilderType = FutureOr<Widget> Function(
  SharedPreferences,
  AppRouter,
  ObjectBox,
);

Future<void> bootstrap(BuilderType builder) async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await initSetup();
  final p = await SharedPreferences.getInstance();
  final appRouter = AppRouter();
  final objectbox = await ObjectBox.create();

  await runZonedGuarded(
    () async => runApp(await builder(p, appRouter, objectbox)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
