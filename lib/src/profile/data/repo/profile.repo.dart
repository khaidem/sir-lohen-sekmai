import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/profile/profile.service.dart';
import 'package:snp_garbage_collection/src/services/data/data.dart';
import '../data.dart';

class ProfileRepo {
  ProfileRepo({required this.service});

  final ProfileService service;

  Future<ProfileModel> getProfile() async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionException();
    }

    final r = await service.profile();
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
