import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/helper/helper.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/customer/customers.service.dart';
import 'package:snp_garbage_collection/src/services/data/data.dart';

import '../data.dart';

class CustomerRepo {
  CustomerRepo({required this.customersService});

  final CustomersService customersService;

  Future<List<CustomerModel>> getCustomers({
    required int page,
    required int limit,
    String? searchString,
  }) async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionException();
    }

    final r = await customersService.customers(
      page: page,
      limit: limit,
      searchString: searchString,
    );

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

      if (r.statusCode == 401) {
        throw UnauthorizeException(
          message: errorResponse.error,
        );
      }

      throw ErrorResponseException(
        statusCode: r.statusCode.toString(),
        message: errorResponse.error,
      );
    }

    final responseBody = r.body!;
    // logger.d(responseBody.toJson());

    return responseBody;
  }
}
