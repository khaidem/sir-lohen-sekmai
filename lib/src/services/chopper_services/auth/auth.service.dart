import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:snp_garbage_collection/src/auth/data/data.dart';

// This is necessary for the generator to work.
part "auth.service.chopper.dart";

@ChopperApi(baseUrl: "/sites")
abstract class AuthService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static AuthService create({ChopperClient? client}) => _$AuthService(client);

  ///
  /// body Payload
  /// {
  ///     "jwt_token": "thisWillBeToken"
  /// }
  @Post(path: '/login')
  Future<Response<LoginResponse>> login(
    @Body() Map<String, dynamic> body,
  );
}
