import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/auth/data/repo/disk.repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.diskRepo,
    required AuthenticationState state,
  }) : super(state);

  final DiskRepo diskRepo;

  Future<void> login({required String token}) async {
    await diskRepo.saveToken(token: token);

    emit(AuthenticationState(
      status: AuthenticationStatus.authorized,
      token: token,
    ));
  }

  Future<void> logout() async {
    diskRepo.deleteToken();

    emit(const AuthenticationState(
      status: AuthenticationStatus.unauthorized,
    ));
  }
}
