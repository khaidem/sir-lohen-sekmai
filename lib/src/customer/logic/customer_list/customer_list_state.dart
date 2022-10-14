part of 'customer_list_cubit.dart';

enum CustomerListStatus { initial, loading, loaded, unauthorize, error }

class CustomerListState extends Equatable {
  const CustomerListState({
    required this.status,
    required this.newCustomerList,
    required this.allCustomerList,
    required this.currentPage,
    this.errorMessage,
  });

  final CustomerListStatus status;

  final List<CustomerModel> newCustomerList;
  final List<CustomerModel> allCustomerList;
  final int currentPage;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        newCustomerList,
        allCustomerList,
        errorMessage,
      ];

  CustomerListState copyWith({
    CustomerListStatus? status,
    List<CustomerModel>? newCustomerList,
    List<CustomerModel>? allCustomerList,
    int? currentPage,
    String? errorMessage,
  }) {
    return CustomerListState(
      status: status ?? this.status,
      newCustomerList: newCustomerList ?? this.newCustomerList,
      allCustomerList: allCustomerList ?? this.allCustomerList,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
