import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class PaymentCardView extends StatelessWidget {
  const PaymentCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          context.router.push(const PaymentRoute());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // const FaIcon(
              //   FontAwesomeIcons.qrcode,
              //   size: 115,
              //   color: Colors.amber,
              // ),
              Image.asset(
                KImage.payment,
                height: 115,
              ),
              const SizedBox(height: 16),
              Text(
                "Payments",
                style: context.theme.textTheme.subtitle2?.copyWith(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
