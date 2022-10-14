import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/qr_scanner/qr_scanner_cubit.dart';

class CustomerInfoView extends StatelessWidget {
  const CustomerInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrScannerState = context.read<QrScannerCubit>().state;

    final name = qrScannerState.scannedData?.name;
    final type = qrScannerState.scannedData?.customerType;
    final number = qrScannerState.scannedData?.customerNo;
    final position = qrScannerState.position;

    final nameStyle = context.theme.textTheme.headline6;
    final typeStyle = context.theme.textTheme.subtitle1;
    final positionStyle = context.theme.textTheme.caption;
    final numberStyle = context.theme.textTheme.subtitle2?.copyWith(
      color: Colors.black54,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (number != null) ...[
          Text(
            number,
            style: numberStyle,
          ),
          const SizedBox(height: 8)
        ],
        if (name != null) ...[
          Text(
            name,
            style: nameStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8)
        ],
        if (type != null) ...[
          Text(
            type,
            style: typeStyle,
          ),
          const SizedBox(height: 8)
        ],
        if (position != null)
          Text(
            "Lat: ${position.latitude}, Long: ${position.longitude}",
            style: positionStyle,
          ),
      ],
    );
  }
}
