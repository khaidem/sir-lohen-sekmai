// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PaymentsService extends PaymentsService {
  _$PaymentsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PaymentsService;

  @override
  Future<Response<List<PaymentModel>>> payments() {
    final $url = '/garbages';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<PaymentModel>, PaymentModel>($request);
  }
}
