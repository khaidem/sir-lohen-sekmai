import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/services/data/data.dart';
import 'package:snp_garbage_collection/src/services/services.dart';

class AuthRepo {
  AuthRepo(this.authService);

  final AuthService authService;

  Future<LoginResponse> login({required LoginDto loginDto}) async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionException();
    }

    final r = await authService.login(loginDto.toJson());
    logger.i({
      'body': r.body.toString(),
      'error': r.error.toString(),
      'statusCode': r.statusCode.toString(),
    });

    if (!r.isSuccessful) {
      final errorResponse = ErrorResponse.fromJson(
        r.error as Map<String, dynamic>,
      );

      // final err = (r.error as Map<String, dynamic>)['error'];
      logger.e(errorResponse.error);

      throw ErrorResponseException(
        statusCode: r.statusCode.toString(),
        message: errorResponse.error,
      );
    }

    final loginResponse = r.body!;
    logger.d(loginResponse.toJson());

    return loginResponse;
  }
}
