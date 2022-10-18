import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';
import 'package:snp_garbage_collection/src/customer_search/pages/customer_search.page.dart';
import 'package:snp_garbage_collection/src/home/widget/widget.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
          // actions: [
          //   IconButton(
          //     onPressed: () async {
          //       final customer = await showSearch(
          //         context: context,
          //         delegate: CustomerSearch(),
          //       );
          //       logger.i("${customer?.customerNo}");
          //       if (customer != null) {
          //         context.router.push(
          //           CustomerDetailsSearchRoute(customerModel: customer),
          //         );
          //       }
          //     },
          //     icon: const Icon(Icons.search),
          //   ),
          // ],
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
          ],
        ));
  }
}
