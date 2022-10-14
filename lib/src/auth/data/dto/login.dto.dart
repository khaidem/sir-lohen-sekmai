import 'package:json_annotation/json_annotation.dart';

part 'login.dto.g.dart';

@JsonSerializable()
class LoginDto {
  LoginDto({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  /// A necessary factory constructor for creating a new LoginDto instance
  /// from a map. Pass the map to the generated `_$LoginDtoFromJson()` constructor.
  /// The constructor is named after the source class, in this case, LoginDto.
  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LoginDtoToJson`.
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
