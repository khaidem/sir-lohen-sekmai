import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';
import 'package:snp_garbage_collection/src/customer/logic/customer_photo/customer_photo_cubit.dart';
import 'package:snp_garbage_collection/src/customer_search/pages/customer_search.page.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
          actions: [
            IconButton(
              onPressed: () async {
                final customer = await showSearch(
                  context: context,
                  delegate: CustomerSearch(),
                );
                logger.i("${customer?.customerNo}");
                if (customer != null) {
                  context.router
                      .push(CustomerDetailsRoute(customerModel: customer));
                }
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: const CustomerListView());
  }
}

class CustomerListView extends StatefulWidget {
  const CustomerListView({Key? key}) : super(key: key);

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  static const _pageLimit = pageLimit;
  late final CustomerRepo customerRepo;
  final PagingController<int, CustomerModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    customerRepo = context.read<CustomerRepo>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await customerRepo.getCustomers(page: pageKey, limit: _pageLimit);
      final isLastPage = newItems.length < _pageLimit;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPagekey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPagekey);
      }
    } catch (error) {
      _pagingController.error = error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: PagedListView<int, CustomerModel>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CustomerModel>(
            itemBuilder: (context, item, index) {
              IconData icon = FontAwesomeIcons.store;
              Color backgroundColor = Colors.amber;
              Color color = Colors.black87;

              if (item.customerType == "RESIDENTIAL") {
                icon = FontAwesomeIcons.home;
                backgroundColor = Colors.green;
                color = Colors.white;
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: FaIcon(
                    icon,
                    size: 21,
                    color: color,
                  ),
                ),
                title: Text(item.name),
                subtitle: Text(item.customerNo),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  /// This will clear previously selected data or photo
                  // context.read<CustomerPhotoCubit>().reset();
                  context.router.push(PaymentDetailsRoute(nameUser: item.name));
                },
              );
            },
            // newPageProgressIndicatorBuilder: (context) =>
            //     const CircularProgressIndicator(),
            // firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
            //   error: _pagingController.error,
            //   onTryAgain: () => _pagingController.refresh(),
            // ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
        onRefresh: () => Future.sync(() => _pagingController.refresh()));
  }
}
