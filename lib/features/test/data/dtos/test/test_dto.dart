// ignore_for_file: overridden_fields, must_be_immutable

import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/test/data/dtos/test/question_dto.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
part 'test_dto.g.dart';

// class TestDtoAdapter extends TypeAdapter<TestDto> {
//
//   TestDto read(BinaryReader reader) {
//     return TestDto.fromMap(reader.readMap());
//   }

//
//   int get typeId => 0;

//
//   void write(BinaryWriter writer, TestDto obj) {
//     writer.writeMap(obj.toMap());
//   }
// }

@HiveType(typeId: 1)
class TestDto with HiveObjectMixin {
  static const hiveBoxName = 'tests';
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final bool isPublic;

  @HiveField(3)
  final String creatorId;

  @HiveField(4)
  final String? imageUrl;

  @HiveField(5)
  final List<QuestionDto>? questions;

  TestDto({
    required this.questions,
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageUrl,
    required this.id,
  });

  static const titleField = 'title';
  static const isPublicField = 'isPublic';
  static const creatorField = 'creator';
  static const imageField = 'image';
  static const idField = 'id';
  static const questionsField = 'questions';

  Map<dynamic, dynamic> toMap() {
    return {
      idField: id,
      titleField: title,
      isPublicField: isPublic,
      creatorField: creatorId,
      imageField: imageUrl,
      questionsField: questions,
    };
  }

  TestEntity toEntity() {
    return TestEntity(
        questions: (questions ?? []).map((e) => e.toEntity()).toList(),
        title: title,
        isPublic: isPublic,
        creatorId: creatorId,
        imageUrl: imageUrl,
        id: id);
  }

  factory TestDto.fromMap(Map<dynamic, dynamic> map) {
    return TestDto(
      questions: (map[questionsField] as List<Map<dynamic, dynamic>>)
          .map((e) => QuestionDto.fromMap(map[questionsField]))
          .toList(),
      title: map[titleField],
      isPublic: map[isPublicField],
      creatorId: map[creatorField],
      imageUrl: map[imageField],
      id: map[idField],
    );
  }
}
