// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      customerId: json['customer_id'] as String,
      year: json['year'] as String,
      month: json['month'] as String,
      monthName: json['month_name'] as String,
      status: json['status'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'year': instance.year,
      'month': instance.month,
      'month_name': instance.monthName,
      'status': instance.status,
      'amount': instance.amount,
    };
