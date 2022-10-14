part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  const ProfileState({
    required this.status,
    this.profileModel,
    this.errorMessage,
  });

  final ProfileStatus status;
  final ProfileModel? profileModel;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, profileModel, errorMessage];

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profileModel,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
