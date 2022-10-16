import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/payment/example.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/model/model.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/customer/customers.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/garbages/garbages.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/payments/payments.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/profile/profile.service.dart';
import '../profile/data/data.dart';

import 'chopper_services/auth/auth.service.dart';
import 'data/type/error_response.dart';
import 'helper/generic_json_convertor.dart';

final chopper = ChopperClient(
    baseUrl: "https://staging.sekmaimunicipalcouncild2d.com/api",
    // baseUrl: "https://sekmai.globizsapp.com/api",
    services: [
      // Create and pass an instance of the generated service to the client
      AuthService.create(),
      GarbagesService.create(),
      CustomersService.create(),
      ProfileService.create(),
      PaymentsService.create(),
    ],
    converter: GenericJsonConvertor({
      LoginResponse: (jsonDate) => LoginResponse.fromJson(jsonDate),
      GarbagesCollectionResponse: (jsonDate) =>
          GarbagesCollectionResponse.fromJson(jsonDate),
      ErrorResponse: (jsonDate) => ErrorResponse.fromJson(jsonDate),
      CustomerInfo: (jsonDate) => CustomerInfo.fromJson(jsonDate),
      CustomerModel: (jsonDate) => CustomerModel.fromJson(jsonDate),
      ProfileModel: (jsonDate) => ProfileModel.fromJson(jsonDate),
      PaymentModel: (jsonDate) => PaymentModel.fromJson(jsonDate),
    }),
    errorConverter: const JsonConverter(),
    interceptors: [
      (Request request) async {
        final p = await SharedPreferences.getInstance();
        final h = request.headers;
        final r = request.copyWith(headers: {
          ...h,
          "Token": "${p.getString('token')}",
        });

        logger.i({"Token": "${p.getString('token')}"});

        return r;
      },
    ]);

// void name() {
//   final authService = chopper.getService<AuthService>();
//   authService.checkPhone({});
// }
