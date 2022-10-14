// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garbages_collection.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GarbagesCollectionDto _$GarbagesCollectionDtoFromJson(
        Map<String, dynamic> json) =>
    GarbagesCollectionDto(
      collectionDate: json['collection_date'] as String,
      customerNo: json['customer_no'] as String,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$GarbagesCollectionDtoToJson(
        GarbagesCollectionDto instance) =>
    <String, dynamic>{
      'collection_date': instance.collectionDate,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'customer_no': instance.customerNo,
    };
