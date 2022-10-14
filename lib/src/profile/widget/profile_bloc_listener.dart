import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';
import 'package:snp_garbage_collection/src/profile/logic/profile/profile_cubit.dart';

class ProfileBlocListener extends StatelessWidget {
  const ProfileBlocListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<ProfileCubit, ProfileState>(
        listener: _profileCubitListener,
      )
    ], child: child);
  }

  void _profileCubitListener(BuildContext context, ProfileState state) {
    switch (state.status) {
      case ProfileStatus.initial:
        break;
      case ProfileStatus.loading:
        showHUD(title: "loading");
        break;
      case ProfileStatus.loaded:
        dismissHUD();
        break;
      case ProfileStatus.error:
        showErrorHUD(title: state.errorMessage!);
        break;
    }
  }
}
