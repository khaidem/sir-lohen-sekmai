part of 'customer_photo_cubit.dart';

enum CustomerPhotoStatus {
  initial,
  uploadInProgress,
  uploaded,
  submitFail,
  unauthorize,

  photoSelecting,
  photoSelected,
  photoSelectionFail,
  photoRemoved,
  photoRemovedFailed,
}

class CustomerPhotoState extends Equatable {
  const CustomerPhotoState({
    required this.status,
    this.position,
    this.imagePath,
    this.imageName,
    this.errorMessage,
  });

  final CustomerPhotoStatus status;
  final Position? position;
  final String? imagePath;
  final String? imageName;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, imagePath, errorMessage];
}
