import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({Key? key, required this.onData}) : super(key: key);
  final void Function(Barcode barcode) onData;

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  IconData icon = Icons.flash_off;

  get future => null;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Stack(
          children: <Widget>[
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
            // Expanded(
            //   flex: 1,
            //   child: Center(
            //     child: (result != null)
            //         ? Text(
            //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
            //           )
            //         : const Text('Scan a code'),
            //   ),
            // )

            Positioned(
              right: 25,
              bottom: 25,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.7),
                child: IconButton(
                  onPressed: () async {
                    await controller?.toggleFlash();
                    final isFlashOn =
                        await controller?.getFlashStatus() ?? false;

                    setState(() {
                      icon = isFlashOn ? Icons.flash_on : Icons.flash_off;
                    });
                  },
                  icon: Icon(icon),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Text(
                  "Scan the customer's QR Code",
                  style: context.theme.textTheme.subtitle2
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (result != null) {
        widget.onData(result!);
        controller.dispose();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
