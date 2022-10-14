part of 'garbages_collection_qrcode_cubit.dart';

enum GarbagesCollectionQrcodeStatus {
  initial,
  submitInProgress,
  submitSuccess,
  submitFail,
  unauthorize
}

class GarbagesCollectionQrcodeState extends Equatable {
  const GarbagesCollectionQrcodeState({
    required this.status,
    this.data,
    this.errorMessage,
  });

  final GarbagesCollectionQrcodeStatus status;
  final GarbagesCollectionResponse? data;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, data, errorMessage];
}
