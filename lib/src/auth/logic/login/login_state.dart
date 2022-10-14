part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loginInProgress,
  loginSuccessful,
  loginFailed,
}

class LoginState extends Equatable {
  const LoginState({
    required this.status,
    this.token,
    this.errorMessage,
  });

  final LoginStatus status;
  final String? token;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, token, errorMessage];
}
