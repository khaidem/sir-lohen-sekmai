import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/logic.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/qr_scanner/qr_scanner_cubit.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class QRScannerBlocListenerWrapper extends StatelessWidget {
  const QRScannerBlocListenerWrapper({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QrScannerCubit, QrScannerState>(listener: _qrScannerCubit),
      ],
      child: child,
    );
  }

  void _qrScannerCubit(BuildContext context, QrScannerState state) {
    switch (state.status) {
      case QRScannerStatus.initial:
        break;
      case QRScannerStatus.scanning:
        showHUD(title: "Scanning");
        break;
      case QRScannerStatus.scanned:
        showSuccessHUD(title: "Scanned Completed");

        final data = state.scannedData!;
        logger.i(data.toJson());

        // context.router.pop();
        context.router.replace(const ScannerResultRoute());
        break;
      case QRScannerStatus.error:
        showErrorHUD(title: state.errorMessage!);
        context.router.pop();
        context.read<QrScannerCubit>().resetState();
        break;
    }
  }
}
