import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/data/dto/dto.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/model/model.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/garbages/garbages.service.dart';
import 'package:snp_garbage_collection/src/services/data/data.dart';
import '../dto/dto.dart';

class GarbageRepo {
  GarbageRepo(this.garbagesService);

  final GarbagesService garbagesService;

  Future<GarbagesCollectionResponse> collected({
    required GarbagesCollectionDto dto,
  }) async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionException();
    }

    final r = await garbagesService.collected(dto.toJson());
    logger.e({
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

      if (r.statusCode == 401) {
        throw UnauthorizeException(
          message: errorResponse.error,
        );
      }

      if (r.statusCode == 409) {
        throw ConflictException(message: errorResponse.error);
      }

      throw ErrorResponseException(
        statusCode: r.statusCode.toString(),
        message: errorResponse.error,
      );
    }

    final responseBody = r.body!;
    logger.d(responseBody.toJson());

    return responseBody;
  }

  Future<GarbagesCollectionResponse> uploadPhoto(UploadPhotoDto dto) async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionException();
    }

    final imagePath = dto.imagePath;
    final collectedOn = dto.collectedOn;
    final customerNo = dto.customerNo;
    final latitude = dto.latitude;
    final longitude = dto.longitude;

    final r = await garbagesService.uploadPhoto(
      imagePath,
      collectedOn,
      customerNo,
      latitude,
      longitude,
    );
    logger.e({
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

      if (r.statusCode == 401) {
        throw UnauthorizeException(
          message: errorResponse.error,
        );
      }

      if (r.statusCode == 409) {
        throw ConflictException(message: errorResponse.error);
      }

      throw ErrorResponseException(
        statusCode: r.statusCode.toString(),
        message: errorResponse.error,
      );
    }

    final responseBody = r.body!;
    logger.d(responseBody.toJson());

    return responseBody;
  }
}
