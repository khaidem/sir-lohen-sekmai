import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/core/core.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepo,
  }) : super(const LoginState(status: LoginStatus.initial));

  final AuthRepo authRepo;

  Future<void> login({required LoginDto loginDto}) async {
    if (_isBusy) return;

    emit(const LoginState(status: LoginStatus.loginInProgress));

    try {
      final r = await authRepo.login(loginDto: loginDto);
      emit(LoginState(
        status: LoginStatus.loginSuccessful,
        token: r.token,
      ));
    } on ErrorResponseException catch (error) {
      emit(LoginState(
        status: LoginStatus.loginFailed,
        errorMessage: error.message,
      ));
    } catch (errorMessage) {
      emit(LoginState(
        status: LoginStatus.loginFailed,
        errorMessage: errorMessage.toString(),
      ));
    }
  }

  bool get _isBusy {
    if (state.status == LoginStatus.loginInProgress) return true;

    return false;
  }
}
