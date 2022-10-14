import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/customer/data/data.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';

part 'customer_list_state.dart';

class CustomerListCubit extends Cubit<CustomerListState> {
  CustomerListCubit({
    required this.customerRepo,
  }) : super(const CustomerListState(
          status: CustomerListStatus.initial,
          allCustomerList: [],
          newCustomerList: [],
          currentPage: 0,
        ));

  final CustomerRepo customerRepo;

  Future<void> getCustomerList({required int page}) async {
    if (_busy) return;

    emit(state.copyWith(
      status: CustomerListStatus.loading,
      allCustomerList: page == 1 ? const [] : null,
    ));

    try {
      // final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
      final newCustomerList = await customerRepo.getCustomers(
        limit: pageLimit,
        page: page,
        searchString: "test",
      );
      final _allCustomerList = [...state.allCustomerList, ...newCustomerList];

      emit(CustomerListState(
        status: CustomerListStatus.loaded,
        newCustomerList: newCustomerList,
        allCustomerList: _allCustomerList,
        currentPage: page,
      ));
    } on UnauthorizeException catch (error) {
      emit(state.copyWith(
        status: CustomerListStatus.unauthorize,
        errorMessage: error.message,
      ));
    } on ErrorResponseException catch (error) {
      emit(state.copyWith(
        status: CustomerListStatus.error,
        errorMessage: error.message,
      ));
    } catch (errorMessage) {
      emit(state.copyWith(
        status: CustomerListStatus.error,
        errorMessage: errorMessage.toString(),
      ));
    }
  }

  Future<void> reset() async {
    emit(const CustomerListState(
      status: CustomerListStatus.initial,
      allCustomerList: [],
      newCustomerList: [],
      currentPage: 0,
    ));
  }

  bool get _busy {
    if (state.status == CustomerListStatus.loading) return true;

    return false;
  }
}
