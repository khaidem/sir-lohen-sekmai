import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    required this.token,
  });

  final String token;

  /// A necessary factory constructor for creating a new LoginResponse instance
  /// from a map. Pass the map to the generated `_$LoginResponseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, LoginResponse.
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LoginResponseToJson`.
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
