// ignore_for_file: overridden_fields, must_be_immutable

import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/quiz/domain/entities/draft_entity.dart';

import '../../../../../core/globals.dart';
import '../question/question_dto.dart';
part 'draft_dto.g.dart';

@HiveType(typeId: 5)
class DraftDto with HiveObjectMixin {
  static const hiveBoxName = 'drafts';
  @HiveField(0)
  final String id;

  @override
  get key => id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final bool isPublic;

  @HiveField(3)
  final String creatorId;

  @HiveField(4)
  final String? imageId;

  @HiveField(5)
  final List<QuestionDto> questions;

  DraftDto({
    required this.questions,
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageId,
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
      titleField: title,
      isPublicField: isPublic,
      creatorField: creatorId,
      imageField: imageId,
      idField: id,
      questionsField: questions.map((e) => e.toMap()),
    };
  }

  Map<String, dynamic> toStringMap() {
    return {
      titleField: title,
      isPublicField: isPublic,
      creatorField: creatorId,
      imageField: imageId,
      idField: id,
      questionsField: questions.map((e) => e.toMap()),
    };
  }

  DraftEntity toEntity() {
    return DraftEntity(
        questions: questions.map((e) => e.toEntity()).toList(),
        title: title,
        isPublic: isPublic,
        creatorId: creatorId,
        imageId: imageId,
        id: id);
  }

  factory DraftDto.fromMap(Map<dynamic, dynamic> map) {
    return DraftDto(
      questions: (map[questionsField] as List<Map<dynamic, dynamic>>)
          .map((e) => QuestionDto.fromMap(map[questionsField]))
          .toList(),
      title: map[titleField],
      isPublic: map[isPublicField],
      creatorId: map[creatorField],
      imageId: map[imageField],
      id: map[idField],
    );
  }

  factory DraftDto.fromEntity(DraftEntity entity) {
    return DraftDto(
      creatorId: entity.creatorId,
      id: entity.id,
      imageId: entity.imageId,
      isPublic: entity.isPublic,
      questions:
          entity.questions.map((e) => QuestionDto.fromEntity(e)).toList(),
      title: entity.title,
    );
  }

  DraftDto copyWith({
    String? id,
    String? title = mockValueForDefault,
    bool? isPublic,
    String? creatorId,
    String? imageId = mockValueForDefault,
    List<QuestionDto>? questions,
  }) {
    return DraftDto(
      questions: questions ?? this.questions,
      isPublic: isPublic ?? this.isPublic,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      title: title == mockValueForDefault ? this.title : title,
      imageId: imageId == mockValueForDefault ? this.imageId : imageId,
    );
  }
}
