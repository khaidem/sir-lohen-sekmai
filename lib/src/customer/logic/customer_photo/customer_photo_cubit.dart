import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/helper/get_position.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/repo/garbages.repo.dart';

part 'customer_photo_state.dart';

class CustomerPhotoCubit extends Cubit<CustomerPhotoState> {
  CustomerPhotoCubit({
    required this.repo,
    required this.draftCubit,
  }) : super(
          const CustomerPhotoState(status: CustomerPhotoStatus.initial),
        );

  final GarbageRepo repo;
  final DraftCubit draftCubit;

  Future<void> uploadPhoto(GarbagesCollectionBox box) async {
    // Future<void> uploadPhoto(UploadPhotoDto dto) async {
    if (_isBusy) return;

    emit(const CustomerPhotoState(
      status: CustomerPhotoStatus.uploadInProgress,
    ));

    final boxId = draftCubit.addToDraft(box: box);

    try {
      await repo.uploadPhoto(box.uploadPhotoDto);

      emit(const CustomerPhotoState(
        status: CustomerPhotoStatus.uploaded,
      ));

      draftCubit.deleteFromDraft(boxId);
    } on ConflictException catch (error) {
      draftCubit.deleteFromDraft(boxId);
      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.submitFail,
        errorMessage: error.message,
      ));
    } on UnauthorizeException catch (error) {
      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.unauthorize,
        errorMessage: error.message,
      ));
    } on ErrorResponseException catch (error) {
      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.submitFail,
        errorMessage: error.message,
      ));
    } catch (errorMessage) {
      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.submitFail,
        errorMessage: errorMessage.toString(),
      ));
    }
  }

  Future<void> photoSelected(String imagePath, String imageName) async {
    emit(const CustomerPhotoState(
      status: CustomerPhotoStatus.photoSelecting,
    ));

    try {
      final Position position = await getPosition();

      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.photoSelected,
        imagePath: imagePath,
        imageName: imageName,
        position: position,
      ));
    } catch (e) {
      emit(CustomerPhotoState(
        status: CustomerPhotoStatus.photoSelectionFail,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deletePhotoFromDisk() async {
    final image = File('${state.imagePath}');

    try {
      await image.delete();
      emit(const CustomerPhotoState(
        status: CustomerPhotoStatus.photoRemoved,
      ));
    } catch (error) {
      emit(const CustomerPhotoState(
        status: CustomerPhotoStatus.photoRemovedFailed,
      ));
    }
  }

  bool get _isBusy {
    if (state.status == CustomerPhotoStatus.uploadInProgress) true;

    return false;
  }

  Future<void> reset() async {
    emit(const CustomerPhotoState(status: CustomerPhotoStatus.initial));
  }
}
