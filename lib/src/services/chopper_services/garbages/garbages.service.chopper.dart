// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garbages.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GarbagesService extends GarbagesService {
  _$GarbagesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GarbagesService;

  @override
  Future<Response<GarbagesCollectionResponse>> collected(
      Map<String, dynamic> body) {
    final $url = '/garbages';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<GarbagesCollectionResponse, GarbagesCollectionResponse>($request);
  }

  @override
  Future<Response<GarbagesCollectionResponse>> uploadPhoto(
      String imagePath,
      String collectedOn,
      String customerNo,
      String latitude,
      String longitude) {
    final $url = '/garbages/customcreate';
    final $parts = <PartValue>[
      PartValue<String>('collection_date', collectedOn),
      PartValue<String>('customer_no', customerNo),
      PartValue<String>('latitude', latitude),
      PartValue<String>('longitude', longitude),
      PartValueFile<String>('image', imagePath)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client
        .send<GarbagesCollectionResponse, GarbagesCollectionResponse>($request);
  }
}
