import 'package:json_annotation/json_annotation.dart';

part 'garbages_collection_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class GarbagesCollectionResponse {
  GarbagesCollectionResponse({
    required this.status,
    required this.customerInfo,
  });

  int status;
  @JsonKey(name: "msg")
  CustomerInfo customerInfo;

  /// A necessary factory constructor for creating a new GarbagesCollectionResponse instance
  /// from a map. Pass the map to the generated `_$GarbagesCollectionResponseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, GarbagesCollectionResponse.
  factory GarbagesCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$GarbagesCollectionResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GarbagesCollectionResponseToJson`.
  Map<String, dynamic> toJson() => _$GarbagesCollectionResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CustomerInfo {
  CustomerInfo({
    required this.id,
    required this.name,
    required this.customerType,
    required this.customerNo,
  });

  int id;
  String name;
  String customerType;
  String customerNo;

  /// A necessary factory constructor for creating a new CustomerInfo instance
  /// from a map. Pass the map to the generated `_$CustomerInfoFromJson()` constructor.
  /// The constructor is named after the source class, in this case, CustomerInfo.
  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CustomerInfoToJson`.
  Map<String, dynamic> toJson() => _$CustomerInfoToJson(this);
}
