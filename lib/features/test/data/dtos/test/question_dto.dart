// ignore_for_file: overridden_fields

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
part "question_dto.g.dart";

@HiveType(typeId: 4)
enum QuestionTypeDto {
  @HiveField(0)
  multipleChoice,
  @HiveField(1)
  answer;

  QuestionType toType() =>
      {
        QuestionTypeDto.answer: QuestionType.answer,
        QuestionTypeDto.multipleChoice: QuestionType.multipleChoice
      }[this] ??
      QuestionType.multipleChoice;

  static QuestionTypeDto fromType(QuestionType type) =>
      {
        QuestionType.answer: QuestionTypeDto.answer,
        QuestionType.multipleChoice: QuestionTypeDto.multipleChoice
      }[type] ??
      QuestionTypeDto.multipleChoice;
}

@HiveType(typeId: 2)
class QuestionDto {
  @HiveField(1)
  final String testId;

  @HiveField(2)
  final QuestionTypeDto typeDto;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final List<MultipleChoiceOptionDto>? options;

  @HiveField(5)
  final List<String>? acceptedAnswers;

  static const testIdField = 'testId';
  static const typeField = 'type';
  static const imageField = 'image';
  static const optionsField = 'options';
  static const acceptedAnswersField = 'acceptedAnswers';

  const QuestionDto({
    this.image,
    required this.options,
    required this.acceptedAnswers,
    required this.testId,
    required this.typeDto,
  });

  factory QuestionDto.fromMap(Map<dynamic, dynamic> map) {
    final optionDtos = (map[optionsField] as List<Map<dynamic, dynamic>>)
        .map((e) => MultipleChoiceOptionDto.fromMap(e))
        .toList();

    return QuestionDto(
      acceptedAnswers: map[acceptedAnswersField],
      testId: map[testIdField],
      typeDto: map[typeField],
      options: optionDtos,
    );
  }

  factory QuestionDto.fromEntity(QuestionEntity entity) {
    if (entity is MultipleChoiceQuestionEntity) {
      return QuestionDto(
        options: entity.options
            .map((e) => MultipleChoiceOptionDto.fromEntity(e))
            .toList(),
        acceptedAnswers: null,
        testId: entity.testId,
        typeDto: QuestionTypeDto.fromType(entity.type),
      );
    } else if (entity is TextInputQuestionEntity) {
      return QuestionDto(
        options: null,
        acceptedAnswers: entity.acceptedAnswers,
        testId: entity.testId,
        typeDto: QuestionTypeDto.fromType(entity.type),
      );
    }
    return QuestionDto(
      options: null,
      acceptedAnswers: null,
      testId: entity.testId,
      typeDto: QuestionTypeDto.fromType(entity.type),
    );
  }

  QuestionEntity toEntity() {
    if (typeDto == QuestionType.answer) {
      return MultipleChoiceQuestionEntity(
          testId: testId,
          options: options?.map((e) => e.toEntity()).toList() ?? []);
    }
    return TextInputQuestionEntity(
        testId: testId,
        type: typeDto.toType(),
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

  factory MultipleChoiceOptionDto.fromEntity(
      MultipleChoiceOptionEntity entity) {
    return MultipleChoiceOptionDto(
      text: entity.text,
      isCorrect: entity.isCorrect,
    );
  }

  factory MultipleChoiceOptionDto.fromMap(Map<dynamic, dynamic> map) {
    return MultipleChoiceOptionDto(
        text: map[textField], isCorrect: map[isCorrectField]);
  }
}
