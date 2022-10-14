part of 'customer_search_bloc.dart';

class CustomerSearchState extends Equatable {
  final bool isLoading;
  final List<CustomerModel> customers;
  final bool hasError;

  const CustomerSearchState({
    required this.isLoading,
    required this.customers,
    required this.hasError,
  });

  factory CustomerSearchState.initial() => const CustomerSearchState(
        customers: [],
        isLoading: false,
        hasError: false,
      );

  factory CustomerSearchState.loading() => const CustomerSearchState(
        customers: [],
        isLoading: true,
        hasError: false,
      );

  factory CustomerSearchState.success(List<CustomerModel> customers) =>
      CustomerSearchState(
        customers: customers,
        isLoading: false,
        hasError: false,
      );

  factory CustomerSearchState.error() => const CustomerSearchState(
        customers: [],
        isLoading: false,
        hasError: true,
      );

  @override
  List<Object> get props => [isLoading, customers, hasError];
}
