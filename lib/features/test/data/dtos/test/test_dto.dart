// ignore_for_file: overridden_fields, must_be_immutable

import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
part 'test_dto.g.dart';

// class TestDtoAdapter extends TypeAdapter<TestDto> {
//   @override
//   TestDto read(BinaryReader reader) {
//     return TestDto.fromMap(reader.readMap());
//   }

//   @override
//   int get typeId => 0;

//   @override
//   void write(BinaryWriter writer, TestDto obj) {
//     writer.writeMap(obj.toMap());
//   }
// }

@HiveType(typeId: 1)
class TestDto extends TestEntity with HiveObjectMixin {
  static const hiveBoxName = 'tests';
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String? title;

  @override
  @HiveField(2)
  final bool isPublic;

  @override
  @HiveField(3)
  final String creatorId;

  @override
  @HiveField(4)
  final String? imageUrl;

  TestDto({
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageUrl,
    required this.id,
  }) : super(
            title: title,
            isPublic: isPublic,
            creatorId: creatorId,
            imageUrl: imageUrl,
            id: id);

  static const titleField = 'title';
  static const isPublicField = 'isPublic';
  static const creatorField = 'creator';
  static const imageField = 'image';
  static const idField = 'id';

  Map<dynamic, dynamic> toMap() {
    return {
      idField: id,
      titleField: title,
      isPublicField: isPublic,
      creatorField: creatorId,
      imageField: imageUrl,
    };
  }

  factory TestDto.fromMap(Map<dynamic, dynamic> map) {
    return TestDto(
      title: map[titleField],
      isPublic: map[isPublicField],
      creatorId: map[creatorField],
      imageUrl: map[imageField],
      id: map[idField],
    );
  }
}
