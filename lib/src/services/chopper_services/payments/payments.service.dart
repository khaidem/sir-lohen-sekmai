import 'package:chopper/chopper.dart';
import 'package:snp_garbage_collection/src/payment/example.dart';

part "payments.service.chopper.dart";

@ChopperApi(baseUrl: "/garbages")
abstract class PaymentsService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static PaymentsService create({ChopperClient? client}) =>
      _$PaymentsService(client);

  @Get()
  Future<Response<List<PaymentModel>>> payments();
}
