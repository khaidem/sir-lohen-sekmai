import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/profile/data/repo/profile.repo.dart';
import '../../data/data.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepo})
      : super(const ProfileState(status: ProfileStatus.initial));

  final ProfileRepo profileRepo;

  Future<void> fetchProfile() async {
    if (_isBusy) return;

    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final profileModel = await profileRepo.getProfile();
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        profileModel: profileModel,
      ));
    } on ErrorResponseException catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: error.message,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  bool get _isBusy {
    if (state.status == ProfileStatus.loading) return true;

    return false;
  }
}
