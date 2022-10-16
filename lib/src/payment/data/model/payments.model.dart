import 'package:json_annotation/json_annotation.dart';

part 'payments.model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaymentModel {
  PaymentModel({
    required this.customerId,
    required this.year,
    required this.month,
    required this.monthName,
    required this.status,
    required this.amount,
  });

  final String customerId;
  final String year;
  final String month;
  final String monthName;
  final String status;
  final String amount;

  /// A necessary factory constructor for creating a new PaymentModel instance
  /// from a map. Pass the map to the generated _$PaymentModelFromJson() constructor.
  /// The constructor is named after the source class, in this case, PaymentModel.
  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  /// toJson is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method _$PaymentModelToJson.
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
