import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  String error;

  /// A necessary factory constructor for creating a new ErrorResponse instance
  /// from a map. Pass the map to the generated `_$ErrorResponseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, ErrorResponse.
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ErrorResponseToJson`.
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
