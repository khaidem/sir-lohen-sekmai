import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snp_garbage_collection/objectbox.g.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/core/repo/repo.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/repo/garbages.repo.dart';

part 'draft_state.dart';

class DraftCubit extends Cubit<DraftState> {
  DraftCubit({
    required this.objectBoxRepo,
    required this.garbageRepo,
  }) : super(const DraftState(status: DraftStatus.initial)) {
    garbageBox = objectBoxRepo.garbagesCollectionBox;
    final queryBuilder = garbageBox.query();
    // This will sort the query by id
    queryBuilder.order(GarbagesCollectionBox_.id, flags: Order.descending);
    final _stream = queryBuilder.watch(triggerImmediately: true);
    // Subscribing to any change in database
    _garbageBoxSubscription = _stream.listen((query) {
      final _draftList = query.find();
      final _draftListLength = _draftList.length;
      emit(DraftState(
        status: DraftStatus.loaded,
        draftList: _draftList,
        totalCount: _draftListLength,
      ));
    });
  }

  final ObjectBoxRepo objectBoxRepo;
  late final StreamSubscription _garbageBoxSubscription;
  late final Box<GarbagesCollectionBox> garbageBox;
  final GarbageRepo garbageRepo;

  @override
  Future<void> close() {
    _garbageBoxSubscription.cancel();
    return super.close();
  }

  /// This method will delete the selected draft
  /// from the database as well as the image file if exists
  void deleteFromDraft(int id) {
    // getting the box from the database to check if it has ImagePath
    // if it has image path then delete the image from the storage
    final _garbage = garbageBox.get(id);
    if (_garbage != null && _garbage.isPhoto) {
      final imagePath = _garbage.imagePath;
      if (imagePath != null) {
        deletePhotoFromDisk(imagePath: imagePath);
      }
    }

    // deleting the box from the database
    garbageBox.remove(id);
  }

  /// This method will find the garbage from the database and return it
  /// if it is not found then it will return null.
  GarbagesCollectionBox? find({required GarbagesCollectionBox box}) {
    final q1 = GarbagesCollectionBox_.collectionDate.equals(box.collectionDate);
    final q2 = GarbagesCollectionBox_.customerNo.equals(box.customerNo);

    final query = garbageBox.query(q1 & q2).build();

    final _box = query.findFirst();
    return _box;
  }

  /// This method will delete Garbage Collection Box from the database as well as the image from the storage
  /// if the image path is not null.
  ///  [box] is the Garbage Collection Box to be deleted
  void findAndDelete({required GarbagesCollectionBox box}) {
    final _box = find(box: box);

    if (_box != null) {
      garbageBox.remove(_box.id);

      // this will delete photo from the disk if the box is have photo
      final imagePath = _box.imagePath;
      if (imagePath != null && _box.isPhoto) {
        deletePhotoFromDisk(imagePath: imagePath);
      }
    }
  }

  int addToDraft({required GarbagesCollectionBox box}) {
    // We will check if the data is already save in database
    // if it is it we will get the id and update the the existing data with new data and return the id
    // else we will create new one and return the id
    final _box = find(box: box);
    if (_box != null) {
      // old data found replacing with new one
      final b = box;
      b.id = _box.id;
      return garbageBox.put(b);
    } else {
      // no old data found so creating new one new data
      // returning new id
      return garbageBox.put(box);
    }
  }

  Future<void> uploadAll() async {
    if (_isBusy) return;

    final garbageBoxList = state.draftList;
    for (var box in garbageBoxList) {
      logger.d(box.toString());

      if (box.isPhoto) {
        // Upload the photo
        emit(state.copyWith(status: DraftStatus.uploading));

        try {
          await garbageRepo.uploadPhoto(box.uploadPhotoDto);
          deleteFromDraft(box.id);
          emit(state.copyWith(status: DraftStatus.uploaded));
        } on ConflictException catch (error) {
          deleteFromDraft(box.id);
          emit(state.copyWith(
            status: DraftStatus.error,
            errorMessage: error.message,
          ));
        } catch (error) {
          // error
          emit(state.copyWith(
            status: DraftStatus.error,
            errorMessage: error.toString(),
          ));
        }
      } else {
        // submit qrcode
        emit(state.copyWith(status: DraftStatus.uploading));
        try {
          await garbageRepo.collected(dto: box.garbagesCollectionDto);
          deleteFromDraft(box.id);
          emit(state.copyWith(status: DraftStatus.uploaded));
        } on ConflictException catch (error) {
          deleteFromDraft(box.id);
          emit(state.copyWith(
            status: DraftStatus.error,
            errorMessage: error.message,
          ));
        } catch (error) {
          // error
          emit(state.copyWith(
            status: DraftStatus.error,
            errorMessage: error.toString(),
          ));
        }
      }
    }
  }

  // Future<void> submitQRCode(GarbagesCollectionBox box) async {
  //   try {
  //     await garbageRepo.collected(dto: box.garbagesCollectionDto);
  //     deleteFromDraft(box.id);
  //   } on ConflictException catch (_) {
  //     deleteFromDraft(box.id);
  //   } catch (error) {
  //     // error
  //   }
  // }

  // Future<void> uploadPhoto(GarbagesCollectionBox box) async {
  //   try {
  //     await garbageRepo.uploadPhoto(box.uploadPhotoDto);
  //     deleteFromDraft(box.id);
  //   } on ConflictException catch (_) {
  //     deleteFromDraft(box.id);
  //   } catch (error) {
  //     // error
  //   }
  // }

  bool get _isBusy {
    if (state.status == DraftStatus.uploading) {
      return true;
    }

    return false;
  }

  /// delete the photo from the disk
  /// [imagePath] is the path of the image.
  Future<void> deletePhotoFromDisk({required String imagePath}) async {
    final image = File(imagePath);

    try {
      await image.delete();
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
