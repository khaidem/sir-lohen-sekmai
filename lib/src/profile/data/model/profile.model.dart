import 'package:json_annotation/json_annotation.dart';

part 'profile.model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileModel {
  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.eMail,
    required this.photo,
    required this.designation,
  });

  final String firstName;
  final String lastName;
  final String eMail;
  final String photo;
  final String designation;

  /// A necessary factory constructor for creating a new ProfileModel instance
  /// from a map. Pass the map to the generated `_$ProfileModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, ProfileModel.
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ProfileModelToJson`.
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
