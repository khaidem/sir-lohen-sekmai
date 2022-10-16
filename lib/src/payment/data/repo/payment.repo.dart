import 'package:snp_garbage_collection/src/payment/example.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/payments/payments.service.dart';

class PaymentRepo {
  PaymentRepo({required this.paymentsService});
  final PaymentsService paymentsService;
}
