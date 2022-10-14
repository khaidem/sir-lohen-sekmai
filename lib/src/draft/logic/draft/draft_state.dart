part of 'draft_cubit.dart';

enum DraftStatus {
  initial,
  loaded,
  uploading,
  uploaded,
  error,
}

class DraftState extends Equatable {
  const DraftState({
    required this.status,
    this.draftList = const [],
    this.errorMessage,
    this.totalCount = 0,
  });

  final DraftStatus status;
  final List<GarbagesCollectionBox> draftList;
  final String? errorMessage;
  final int totalCount;

  @override
  List<Object?> get props => [status, draftList, errorMessage];

  DraftState copyWith({
    DraftStatus? status,
    List<GarbagesCollectionBox>? draftList,
    String? errorMessage,
  }) {
    return DraftState(
      status: status ?? this.status,
      draftList: draftList ?? this.draftList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
