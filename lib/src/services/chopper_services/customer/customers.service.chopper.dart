// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CustomersService extends CustomersService {
  _$CustomersService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CustomersService;

  @override
  Future<Response<List<CustomerModel>>> customers(
      {required int page, required int limit, String? searchString}) {
    final $url = '/garbages';
    final $params = <String, dynamic>{
      '_page': page,
      '_limit': limit,
      '_q': searchString
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<CustomerModel>, CustomerModel>($request);
  }
}
