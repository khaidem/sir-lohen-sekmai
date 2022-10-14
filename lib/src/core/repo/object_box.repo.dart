import 'package:snp_garbage_collection/objectbox.g.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/core/object_box/objectbox.dart';

class ObjectBoxRepo {
  ObjectBoxRepo({required this.objectBox});

  final ObjectBox objectBox;

  Store get store => objectBox.store;

  Box<GarbagesCollectionBox> get garbagesCollectionBox =>
      store.box<GarbagesCollectionBox>();
}
