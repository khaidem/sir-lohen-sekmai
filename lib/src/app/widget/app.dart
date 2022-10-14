import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/core/constant/constant.dart';
import 'package:snp_garbage_collection/src/core/object_box/objectbox.dart';
import 'package:snp_garbage_collection/src/router/widget/app_router.gr.dart';

import 'multi_bloc.wrapper.dart';
import 'multi_repository_provider.wrapper.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.appRouter,
    required this.sharedPreferences,
    required this.objectbox,
  }) : super(key: key);

  final AppRouter appRouter;
  final SharedPreferences sharedPreferences;
  final ObjectBox objectbox;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProviderWrapper(
      objectbox: objectbox,
      sharedPreferences: sharedPreferences,
      child: MultiBlocWrapper(
        child: MaterialApp.router(
          title: appName,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          // theme: ThemeData(),
          theme: FlexColorScheme.light(scheme: FlexScheme.green).toTheme,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
