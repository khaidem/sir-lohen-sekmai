part of 'qr_scanner_cubit.dart';

enum QRScannerStatus { initial, scanning, scanned, error }

class QrScannerState extends Equatable {
  const QrScannerState({
    required this.status,
    this.scannedData,
    this.position,
    this.qrString,
    this.errorMessage,
  });

  final QRScannerStatus status;
  final QRScannedData? scannedData;
  final Position? position;
  final String? qrString;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, scannedData, errorMessage, qrString];
}
