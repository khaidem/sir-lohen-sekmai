import "dart:async";
import 'package:chopper/chopper.dart';
import '../../../profile/data/data.dart';

// This is necessary for the generator to work.
part "profile.service.chopper.dart";

@ChopperApi(baseUrl: "/sites")
abstract class ProfileService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static ProfileService create({ChopperClient? client}) =>
      _$ProfileService(client);

  ///
  /// body Payload
  /// {
  ///     "jwt_token": "thisWillBeToken"
  /// }
  @Get(path: '/profile')
  Future<Response<ProfileModel>> profile();
}
