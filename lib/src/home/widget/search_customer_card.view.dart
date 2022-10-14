import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/data/data.dart';
import 'package:snp_garbage_collection/src/customer_search/pages/customer_search.page.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class SearchCustomerCardView extends StatelessWidget {
  const SearchCustomerCardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 0.5,
      child: InkWell(
        onTap: () async {
          final customer = await showSearch<CustomerModel>(
            context: context,
            delegate: CustomerSearch(),
          );
          logger.i("${customer?.name}");

          if (customer != null) {
            context.router.push(
              CustomerDetailsRoute(customerModel: customer),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // const FaIcon(
              //   FontAwesomeIcons.searchengin,
              //   size: 115,
              //   color: Colors.amber,
              // ),
              Image.asset(
                KImage.search,
                height: 115,
              ),
              const SizedBox(height: 16),
              Text(
                "Search Customer",
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
