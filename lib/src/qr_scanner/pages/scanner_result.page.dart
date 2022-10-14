import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/core/widgets/elevated_button.view.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';

import '../qr_scanner.dart';
import '../data/dto/dto.dart';

class ScannerResultPage extends StatelessWidget {
  const ScannerResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GarbagesCollectionQrcodeListenerWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer Info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(height: 50),
                QrView(),
                SizedBox(height: 50),
                CustomerInfoView(),
                SizedBox(height: 50),
                ScanSubmitButton(),
                SizedBox(height: 20),
                ScanSubmitLaterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScanSubmitButton extends StatelessWidget {
  const ScanSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.theme.textTheme.button?.copyWith(
      color: Colors.white,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.upload),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
        ),
        label: Text(
          'Submit'.toUpperCase(),
          style: buttonStyle,
        ),
        onPressed: () {
          final qrScannerState = context.read<QrScannerCubit>().state;
          final scannedData = qrScannerState.scannedData;
          final position = qrScannerState.position!;

          final box = GarbagesCollectionBox(
            collectionDate: getDateNow(),
            customerNo: scannedData!.customerNo,
            customerType: scannedData.customerType,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            name: scannedData.name,
            qrString: qrScannerState.qrString,
            isPhoto: false,
            imagePath: null,
          );

          context.read<GarbagesCollectionQrcodeCubit>().collect(box);
        },
      ),
    );
  }
}

class ScanSubmitLaterButton extends StatelessWidget {
  const ScanSubmitLaterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.theme.textTheme.button;

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        icon: const Icon(Icons.save_outlined),
        style: ElevatedButton.styleFrom(
          // primary: Colors.black,
          padding: const EdgeInsets.all(8),
        ),
        label: Text(
          'Submit Later'.toUpperCase(),
          style: buttonStyle,
        ),
        onPressed: () {
          final qrScannerState = context.read<QrScannerCubit>().state;
          final scannedData = qrScannerState.scannedData;
          final position = qrScannerState.position!;

          final box = GarbagesCollectionBox(
            collectionDate: getDateNow(),
            customerNo: scannedData!.customerNo,
            customerType: scannedData.customerType,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            name: scannedData.name,
            qrString: qrScannerState.qrString,
            isPhoto: false,
            imagePath: null,
          );

          context.read<DraftCubit>().addToDraft(box: box);
          context.router.pop();
        },
      ),
    );
  }
}
