import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/logic/logic.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/logic.dart';

class GarbagesCollectionQrcodeListenerWrapper extends StatelessWidget {
  const GarbagesCollectionQrcodeListenerWrapper({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GarbagesCollectionQrcodeCubit,
            GarbagesCollectionQrcodeState>(
          listener: _garbagesCollectionQrcodeCubit,
        )
      ],
      child: child,
    );
  }

  void _garbagesCollectionQrcodeCubit(
    BuildContext context,
    GarbagesCollectionQrcodeState state,
  ) {
    switch (state.status) {
      case GarbagesCollectionQrcodeStatus.initial:
        break;
      case GarbagesCollectionQrcodeStatus.submitInProgress:
        showHUD(title: "Submitting");
        break;
      case GarbagesCollectionQrcodeStatus.submitSuccess:
        showErrorHUD(title: "Submitted");
        context.router.pop();
        break;
      case GarbagesCollectionQrcodeStatus.submitFail:
        showErrorHUD(title: state.errorMessage!);
        context.router.pop();
        break;
      case GarbagesCollectionQrcodeStatus.unauthorize:
        context.read<AuthenticationCubit>().logout();
        break;
    }
  }
}
