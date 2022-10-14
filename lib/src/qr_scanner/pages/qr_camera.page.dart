import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:snp_garbage_collection/src/core/widgets/widgets.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/qr_scanner/qr_scanner_cubit.dart';
import 'package:snp_garbage_collection/src/qr_scanner/widget/qr_scanner_bloc_listener_wrapper.dart';
import 'package:snp_garbage_collection/src/qr_scanner/widget/widget.dart';

class QRCameraPage extends StatelessWidget {
  const QRCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRScannerBlocListenerWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LocationPermissionView(
            child: CameraPermissionView(
              child: Center(
                child: QRScannerView(
                  onData: (barcode) {
                    BlocProvider.of<QrScannerCubit>(context)
                        .dataScanned(barcode.code);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
