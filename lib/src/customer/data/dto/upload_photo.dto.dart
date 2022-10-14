class UploadPhotoDto {
  final String imagePath;
  final String collectedOn;
  final String customerNo;
  final String latitude;
  final String longitude;

  const UploadPhotoDto({
    required this.imagePath,
    required this.collectedOn,
    required this.customerNo,
    required this.latitude,
    required this.longitude,
  });
}
