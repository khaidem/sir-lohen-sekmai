import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/customer_search/logic/customer_search/customer_search_bloc.dart';

class CustomerSearch extends SearchDelegate<CustomerModel> {
  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) {
    final customerSearchBloc = context.read<CustomerSearchBloc>();
    customerSearchBloc.add(CustomerSearchEvent(query));

    return BlocBuilder<CustomerSearchBloc, CustomerSearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.hasError) {
          return const Center(
            child: Text('No Result Found'),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final item = state.customers[index];

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
              onTap: () => close(context, item),
            );

            // return ListTile(
            //   leading: const Icon(Icons.location_city),
            //   title: Text(state.customers[index].name),
            //   onTap: () => close(context, state.customers[index]),
            // );
          },
          itemCount: state.customers.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
