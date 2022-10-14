// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['id'] as int,
      name: json['name'] as String,
      customerType: json['customer_type'] as String,
      customerNo: json['customer_no'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'customer_type': instance.customerType,
      'customer_no': instance.customerNo,
    };
