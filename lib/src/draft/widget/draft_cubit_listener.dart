import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';

class DraftListener extends StatelessWidget {
  const DraftListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      child: child,
      listeners: [
        BlocListener<DraftCubit, DraftState>(
          listener: _draftCubitListener,
        )
      ],
    );
  }

  void _draftCubitListener(BuildContext context, DraftState state) {
    switch (state.status) {
      case DraftStatus.initial:
        break;
      case DraftStatus.uploading:
        showHUD(title: "Uploading");
        break;
      case DraftStatus.uploaded:
        showSuccessHUD(title: "Upload Completed");
        break;
      case DraftStatus.error:
        showErrorHUD(title: state.errorMessage!);
        break;
      case DraftStatus.loaded:
        break;
    }
  }
}
