import 'package:json_annotation/json_annotation.dart';

part 'customer.model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CustomerModel {
  CustomerModel({
    required this.id,
    required this.name,
    required this.customerType,
    required this.customerNo,
  });

  final int id;
  final String name;
  final String customerType;
  final String customerNo;

  /// A necessary factory constructor for creating a new CustomerModel instance
  /// from a map. Pass the map to the generated `_$CustomerModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, CustomerModel.
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CustomerModelToJson`.
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
