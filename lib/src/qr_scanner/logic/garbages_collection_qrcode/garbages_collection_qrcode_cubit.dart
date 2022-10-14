import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/model/model.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/repo/garbages.repo.dart';

import '../../data/data.dart';

part 'garbages_collection_qrcode_state.dart';

class GarbagesCollectionQrcodeCubit
    extends Cubit<GarbagesCollectionQrcodeState> {
  GarbagesCollectionQrcodeCubit({
    required this.garbageRepo,
    required this.draftCubit,
  }) : super(
          const GarbagesCollectionQrcodeState(
            status: GarbagesCollectionQrcodeStatus.initial,
          ),
        );

  final GarbageRepo garbageRepo;
  final DraftCubit draftCubit;

  Future<void> collect(GarbagesCollectionBox box) async {
    if (_isBusy) return;

    emit(const GarbagesCollectionQrcodeState(
      status: GarbagesCollectionQrcodeStatus.submitInProgress,
    ));
    final boxId = draftCubit.addToDraft(box: box);

    try {
      logger.i(box.garbagesCollectionDto.toJson());

      final r = await garbageRepo.collected(dto: box.garbagesCollectionDto);
      emit(GarbagesCollectionQrcodeState(
        status: GarbagesCollectionQrcodeStatus.submitSuccess,
        data: r,
      ));

      draftCubit.deleteFromDraft(boxId);
    } on ConflictException catch (error) {
      draftCubit.deleteFromDraft(boxId);
      emit(GarbagesCollectionQrcodeState(
        status: GarbagesCollectionQrcodeStatus.submitFail,
        errorMessage: error.message,
      ));
    } on UnauthorizeException catch (error) {
      draftCubit.deleteFromDraft(boxId);
      emit(GarbagesCollectionQrcodeState(
        status: GarbagesCollectionQrcodeStatus.unauthorize,
        errorMessage: error.message,
      ));
    } on ErrorResponseException catch (error) {
      emit(GarbagesCollectionQrcodeState(
        status: GarbagesCollectionQrcodeStatus.submitFail,
        errorMessage: error.message,
      ));
    } catch (errorMessage) {
      emit(GarbagesCollectionQrcodeState(
        status: GarbagesCollectionQrcodeStatus.submitFail,
        errorMessage: errorMessage.toString(),
      ));
    }
  }

  bool get _isBusy {
    if (state.status == GarbagesCollectionQrcodeStatus.submitInProgress) {
      return true;
    }

    return false;
  }
}
