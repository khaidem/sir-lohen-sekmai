import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// Call this somewhere on start up the application
void hudSetup() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.amber
    ..backgroundColor = Colors.black.withOpacity(0.95)
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = Colors.white
    ..errorWidget = const Icon(
      Icons.error_outline_sharp,
      color: Colors.white,
    )
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

void showHUD({required String title}) {
  EasyLoading.show(
    status: title,
    maskType: EasyLoadingMaskType.black,
  );
}

void showSuccessHUD({required String title}) {
  EasyLoading.showSuccess(title);
}

void showInfoHUD({required String title}) {
  EasyLoading.showInfo(title);
}

void showErrorHUD({required String title}) {
  EasyLoading.showError(
    title,
    duration: const Duration(seconds: 5),
  );
}

void showToastHUD({required String title}) {
  EasyLoading.showToast(title);
}

void showProgressHUD({required String title, required double progress}) {
  EasyLoading.showProgress(
    progress,
    status: title,
    maskType: EasyLoadingMaskType.black,
  );
}

void dismissHUD() {
  EasyLoading.dismiss();
}
