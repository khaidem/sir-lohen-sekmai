part of 'customer_search_bloc.dart';

class CustomerSearchEvent extends Equatable {
  final String query;

  const CustomerSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
