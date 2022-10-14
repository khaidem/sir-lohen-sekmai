// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      eMail: json['e_mail'] as String,
      photo: json['photo'] as String,
      designation: json['designation'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'e_mail': instance.eMail,
      'photo': instance.photo,
      'designation': instance.designation,
    };
