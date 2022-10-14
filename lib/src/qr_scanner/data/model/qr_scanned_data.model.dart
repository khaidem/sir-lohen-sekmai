import 'package:json_annotation/json_annotation.dart';

part 'qr_scanned_data.model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QRScannedData {
  QRScannedData({
    required this.name,
    required this.customerType,
    required this.customerNo,
  });

  String name;
  String customerType;
  String customerNo;

  /// A necessary factory constructor for creating a new QRScannedData instance
  /// from a map. Pass the map to the generated `_$QRScannedDataFromJson()` constructor.
  /// The constructor is named after the source class, in this case, QRScannedData.
  factory QRScannedData.fromJson(Map<String, dynamic> json) =>
      _$QRScannedDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$QRScannedDataToJson`.
  Map<String, dynamic> toJson() => _$QRScannedDataToJson(this);
}
