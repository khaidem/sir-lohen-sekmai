part of 'authentication_cubit.dart';

enum AuthenticationStatus { authorized, unauthorized, error }

class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
    this.token,
    this.errorMessage,
  });

  final AuthenticationStatus status;
  final String? token;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, token, errorMessage];
}
