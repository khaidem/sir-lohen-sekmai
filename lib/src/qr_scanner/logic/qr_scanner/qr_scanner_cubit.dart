import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/helper/get_position.dart';

import '../../data/data.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  QrScannerCubit()
      : super(const QrScannerState(
          status: QRScannerStatus.initial,
        ));

  Future<void> dataScanned(String qrCode) async {
    emit(const QrScannerState(status: QRScannerStatus.scanning));

    try {
      final decodedData = utf8.decode(base64.decode(qrCode));
      final jsonData = jsonDecode(decodedData.toString());
      final jsonToMap = jsonData as Map<String, dynamic>;
      final _scannedData = QRScannedData.fromJson(jsonToMap);

      /// Getting User's Location
      /// Note That All the Location Permission are handle before showing UI of scanner
      final Position _position = await getPosition();

      emit(QrScannerState(
        status: QRScannerStatus.scanned,
        scannedData: _scannedData,
        position: _position,
        qrString: qrCode,
      ));
    } on FormatException catch (error) {
      logger.e(error.message);
      emit(const QrScannerState(
        status: QRScannerStatus.error,
        errorMessage: "Invalid QR Code",
      ));
    } catch (error) {
      logger.e(error.toString());

      emit(QrScannerState(
        status: QRScannerStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void resetState() {
    emit(const QrScannerState(
      status: QRScannerStatus.initial,
    ));
  }
}
