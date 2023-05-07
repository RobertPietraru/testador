// ignore_for_file: overridden_fields

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
part "question_dto.g.dart";
@HiveType(typeId: 2)
class QuestionDto {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String testId;

  @HiveField(2)
  final QuestionType type;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final List<MultipleChoiceOptionDto>? options;

  @HiveField(5)
  final List<String>? acceptedAnswers;

  static const idField = 'id';
  static const testIdField = 'testId';
  static const typeField = 'type';
  static const imageField = 'image';
  static const optionsField = 'options';
  static const acceptedAnswersField = 'acceptedAnswers';

  const QuestionDto({
    this.image,
    required this.options,
    required this.acceptedAnswers,
    required this.id,
    required this.testId,
    required this.type,
  });

  factory QuestionDto.fromMap(Map<dynamic, dynamic> map) {
    final optionDtos = (map[optionsField] as List<Map<dynamic, dynamic>>)
        .map((e) => MultipleChoiceOptionDto.fromMap(e))
        .toList();

    return QuestionDto(
      acceptedAnswers: map[acceptedAnswersField],
      id: map[idField],
      testId: map[testIdField],
      type: map[typeField],
      options: optionDtos,
    );
  }

  QuestionEntity toEntity() {
    if (type == QuestionType.answer) {
      return MultipleChoiceQuestionEntity(
          id: id,
          testId: testId,
          options: options?.map((e) => e.toEntity()).toList() ?? []);
    }
    return TextInputQuestionEntity(
        id: id,
        testId: testId,
        type: type,
        acceptedAnswers: acceptedAnswers ?? []);
  }
}

@HiveType(typeId: 3)
class MultipleChoiceOptionDto {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isCorrect;

  const MultipleChoiceOptionDto({
    required this.text,
    required this.isCorrect,
  });

  static const textField = 'text';
  static const isCorrectField = 'isCorrect';

  MultipleChoiceOptionEntity toEntity() {
    return MultipleChoiceOptionEntity(
      text: text,
      isCorrect: isCorrect,
    );
  }

  factory MultipleChoiceOptionDto.fromMap(Map<dynamic, dynamic> map) {
    return MultipleChoiceOptionDto(
        text: map[textField], isCorrect: map[isCorrectField]);
  }
}
