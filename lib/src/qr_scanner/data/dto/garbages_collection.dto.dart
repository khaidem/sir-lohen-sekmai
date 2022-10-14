import 'package:json_annotation/json_annotation.dart';

part 'garbages_collection.dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GarbagesCollectionDto {
  GarbagesCollectionDto({
    required this.collectionDate,
    required this.customerNo,
    this.longitude,
    this.latitude,
  });

  final String collectionDate;
  final String? longitude;
  final String? latitude;
  final String customerNo;

  /// A necessary factory constructor for creating a new GarbagesCollectionDto instance
  /// from a map. Pass the map to the generated `_$GarbagesCollectionDtoFromJson()` constructor.
  /// The constructor is named after the source class, in this case, GarbagesCollectionDto.
  factory GarbagesCollectionDto.fromJson(Map<String, dynamic> json) =>
      _$GarbagesCollectionDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GarbagesCollectionDtoToJson`.
  Map<String, dynamic> toJson() => _$GarbagesCollectionDtoToJson(this);

  GarbagesCollectionDto copyWith({
    String? collectionDate,
    String? longitude,
    String? latitude,
    String? customerNo,
  }) {
    return GarbagesCollectionDto(
      collectionDate: collectionDate ?? this.collectionDate,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      customerNo: customerNo ?? this.customerNo,
    );
  }
}
