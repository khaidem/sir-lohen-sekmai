// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProfileService extends ProfileService {
  _$ProfileService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileService;

  @override
  Future<Response<ProfileModel>> profile() {
    final $url = '/sites/profile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ProfileModel, ProfileModel>($request);
  }
}
