import 'package:objectbox/objectbox.dart';

import '../../customer/data/data.dart';
import '../../qr_scanner/data/data.dart';

@Entity()
class GarbagesCollectionBox {
  int id;
  final String collectionDate;
  final String longitude;
  final String latitude;
  final String customerNo;
  final String name;
  final String customerType;
  final String? imagePath;
  final String? qrString;
  final bool isPhoto;

  GarbagesCollectionBox({
    this.id = 0,
    required this.collectionDate,
    required this.longitude,
    required this.latitude,
    required this.customerNo,
    required this.name,
    required this.customerType,
    this.imagePath,
    this.qrString,
    this.isPhoto = false,
  });

  GarbagesCollectionDto get garbagesCollectionDto => GarbagesCollectionDto(
        collectionDate: collectionDate,
        customerNo: customerNo,
        latitude: latitude,
        longitude: longitude,
      );

  UploadPhotoDto get uploadPhotoDto => UploadPhotoDto(
        collectedOn: collectionDate,
        customerNo: customerNo,
        imagePath: imagePath!,
        latitude: latitude,
        longitude: longitude,
      );

  @override
  String toString() {
    return 'id: $id, collectionDate: $collectionDate, customerNo: $customerNo, name: $name, isPhoto: $isPhoto';
  }
}
