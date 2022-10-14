// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/core/object_box/garbages_collection.box.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3635083131088358320),
      name: 'GarbagesCollectionBox',
      lastPropertyId: const IdUid(10, 4331275718908045829),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6801128762510117714),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4999858860417089911),
            name: 'collectionDate',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5862429485710861727),
            name: 'longitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7053175038788751444),
            name: 'latitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 571796253365966868),
            name: 'customerNo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5236672908339872603),
            name: 'imagePath',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3676064074918147159),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 8057050968395241108),
            name: 'customerType',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7640669980688317652),
            name: 'qrString',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 4331275718908045829),
            name: 'isPhoto',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 3635083131088358320),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    GarbagesCollectionBox: EntityDefinition<GarbagesCollectionBox>(
        model: _entities[0],
        toOneRelations: (GarbagesCollectionBox object) => [],
        toManyRelations: (GarbagesCollectionBox object) => {},
        getId: (GarbagesCollectionBox object) => object.id,
        setId: (GarbagesCollectionBox object, int id) {
          object.id = id;
        },
        objectToFB: (GarbagesCollectionBox object, fb.Builder fbb) {
          final collectionDateOffset = fbb.writeString(object.collectionDate);
          final longitudeOffset = fbb.writeString(object.longitude);
          final latitudeOffset = fbb.writeString(object.latitude);
          final customerNoOffset = fbb.writeString(object.customerNo);
          final imagePathOffset = object.imagePath == null
              ? null
              : fbb.writeString(object.imagePath!);
          final nameOffset = fbb.writeString(object.name);
          final customerTypeOffset = fbb.writeString(object.customerType);
          final qrStringOffset = object.qrString == null
              ? null
              : fbb.writeString(object.qrString!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, collectionDateOffset);
          fbb.addOffset(2, longitudeOffset);
          fbb.addOffset(3, latitudeOffset);
          fbb.addOffset(4, customerNoOffset);
          fbb.addOffset(5, imagePathOffset);
          fbb.addOffset(6, nameOffset);
          fbb.addOffset(7, customerTypeOffset);
          fbb.addOffset(8, qrStringOffset);
          fbb.addBool(9, object.isPhoto);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = GarbagesCollectionBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              collectionDate:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              longitude:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              latitude:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              customerNo:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 16, ''),
              customerType:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 18, ''),
              imagePath: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              qrString: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              isPhoto: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 22, false));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [GarbagesCollectionBox] entity fields to define ObjectBox queries.
class GarbagesCollectionBox_ {
  /// see [GarbagesCollectionBox.id]
  static final id =
      QueryIntegerProperty<GarbagesCollectionBox>(_entities[0].properties[0]);

  /// see [GarbagesCollectionBox.collectionDate]
  static final collectionDate =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[1]);

  /// see [GarbagesCollectionBox.longitude]
  static final longitude =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[2]);

  /// see [GarbagesCollectionBox.latitude]
  static final latitude =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[3]);

  /// see [GarbagesCollectionBox.customerNo]
  static final customerNo =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[4]);

  /// see [GarbagesCollectionBox.imagePath]
  static final imagePath =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[5]);

  /// see [GarbagesCollectionBox.name]
  static final name =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[6]);

  /// see [GarbagesCollectionBox.customerType]
  static final customerType =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[7]);

  /// see [GarbagesCollectionBox.qrString]
  static final qrString =
      QueryStringProperty<GarbagesCollectionBox>(_entities[0].properties[8]);

  /// see [GarbagesCollectionBox.isPhoto]
  static final isPhoto =
      QueryBooleanProperty<GarbagesCollectionBox>(_entities[0].properties[9]);
}
