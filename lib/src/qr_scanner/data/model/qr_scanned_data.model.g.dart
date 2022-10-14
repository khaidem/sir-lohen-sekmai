// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_scanned_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRScannedData _$QRScannedDataFromJson(Map<String, dynamic> json) =>
    QRScannedData(
      name: json['name'] as String,
      customerType: json['customer_type'] as String,
      customerNo: json['customer_no'] as String,
    );

Map<String, dynamic> _$QRScannedDataToJson(QRScannedData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'customer_type': instance.customerType,
      'customer_no': instance.customerNo,
    };
