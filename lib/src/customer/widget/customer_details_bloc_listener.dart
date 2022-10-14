import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snp_garbage_collection/src/core/logic/logic.dart';
import 'package:snp_garbage_collection/src/core/widgets/hud.dart';
import 'package:snp_garbage_collection/src/customer/logic/customer_photo/customer_photo_cubit.dart';

class CustomerDetailsBlocListener extends StatelessWidget {
  const CustomerDetailsBlocListener({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CustomerPhotoCubit, CustomerPhotoState>(
          listener: _customerPhotoState,
        )
      ],
      child: child,
    );
  }

  void _customerPhotoState(BuildContext context, CustomerPhotoState state) {
    switch (state.status) {
      case CustomerPhotoStatus.initial:
        break;
      case CustomerPhotoStatus.uploadInProgress:
        showHUD(title: 'Uploading');
        break;
      case CustomerPhotoStatus.uploaded:
        showSuccessHUD(title: "Uploaded");
        context.router.pop();
        break;
      case CustomerPhotoStatus.submitFail:
        final errorMessage = state.errorMessage!;
        showErrorHUD(title: errorMessage);
        break;
      case CustomerPhotoStatus.unauthorize:
        context.read<AuthenticationCubit>().logout();
        break;

      case CustomerPhotoStatus.photoSelecting:
        showHUD(title: "Wait..");
        break;
      case CustomerPhotoStatus.photoSelected:
        dismissHUD();
        break;
      case CustomerPhotoStatus.photoSelectionFail:
        final errorMessage = state.errorMessage!;
        showErrorHUD(title: errorMessage);
        break;
      case CustomerPhotoStatus.photoRemoved:
        showSuccessHUD(title: "Photo Deleted");
        break;
      case CustomerPhotoStatus.photoRemovedFailed:
        break;
    }
  }
}
