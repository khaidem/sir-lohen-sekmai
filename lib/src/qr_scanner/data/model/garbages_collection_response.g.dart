// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garbages_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GarbagesCollectionResponse _$GarbagesCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    GarbagesCollectionResponse(
      status: json['status'] as int,
      customerInfo: CustomerInfo.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GarbagesCollectionResponseToJson(
        GarbagesCollectionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.customerInfo.toJson(),
    };

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) => CustomerInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      customerType: json['customer_type'] as String,
      customerNo: json['customer_no'] as String,
    );

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'customer_type': instance.customerType,
      'customer_no': instance.customerNo,
    };
