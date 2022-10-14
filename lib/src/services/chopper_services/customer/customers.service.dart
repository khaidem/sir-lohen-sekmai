import "dart:async";
import 'package:chopper/chopper.dart';

import 'package:snp_garbage_collection/src/customer/data/data.dart';

// This is necessary for the generator to work.
part "customers.service.chopper.dart";

@ChopperApi(baseUrl: "/garbages")
abstract class CustomersService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static CustomersService create({ChopperClient? client}) =>
      _$CustomersService(client);

  @Get()
  Future<Response<List<CustomerModel>>> customers({
    @Query("_page") required int page,
    @Query("_limit") required int limit,
    @Query("_q") String? searchString,
  });
}
