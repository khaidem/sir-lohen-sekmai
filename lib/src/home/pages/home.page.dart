import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/home/widget/payment_card.view.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // ElevatedButton(
          //   onPressed: () {
          //     context.read<AuthenticationCubit>().logout();
          //   },
          //   child: const Text('LogOut'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.router.push(const CustomersRoute());
          //   },
          //   child: const Text('Customers Page'),
          // ),

          QRCardView(),
          CustomerCardView(),
          SearchCustomerCardView(),
          PaymentCardView()
        ],
      ),
    );
  }
}
