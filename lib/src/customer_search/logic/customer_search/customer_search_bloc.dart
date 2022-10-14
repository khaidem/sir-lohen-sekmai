import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';

part 'customer_search_event.dart';
part 'customer_search_state.dart';

class CustomerSearchBloc
    extends Bloc<CustomerSearchEvent, CustomerSearchState> {
  CustomerSearchBloc({required this.customerRepo})
      : super(CustomerSearchState.initial()) {
    on<CustomerSearchEvent>(_onCustomerSearchEvent);
  }

  final CustomerRepo customerRepo;

  Future<void> _onCustomerSearchEvent(
    CustomerSearchEvent event,
    Emitter<CustomerSearchState> emit,
  ) async {
    emit(CustomerSearchState.loading());

    try {
      final customers = await customerRepo.getCustomers(
        page: 1,
        limit: 20,
        searchString: event.query,
      );
      emit(CustomerSearchState.success(customers));
    } catch (e) {
      emit(CustomerSearchState.error());
    }
  }
}
