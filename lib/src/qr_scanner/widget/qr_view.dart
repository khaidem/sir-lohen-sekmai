import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/qr_scanner/qr_scanner_cubit.dart';

class QrView extends StatelessWidget {
  const QrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrString = context.read<QrScannerCubit>().state.qrString!;
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(8),
        child: QrImage(
          data: qrString,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              3.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
    );
  }
}
