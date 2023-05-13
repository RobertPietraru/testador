// ignore_for_file: overridden_fields

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';

import '../../../../../core/globals.dart';
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
  final QuestionTypeDto type;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final List<MultipleChoiceOptionDto>? options;

  @HiveField(5)
  final List<String>? acceptedAnswers;

  @HiveField(6)
  final String? text;

  @HiveField(7)
  final String id;
  static const testIdField = 'testId';
  static const typeField = 'type';
  static const imageField = 'image';
  static const optionsField = 'options';
  static const acceptedAnswersField = 'acceptedAnswers';
  static const textField = 'text';
  static const idField = 'id';

  const QuestionDto({
    required this.id,
    required this.text,
    this.image,
    required this.options,
    required this.acceptedAnswers,
    required this.testId,
    required this.type,
  });

  factory QuestionDto.fromMap(Map<dynamic, dynamic> map) {
    final optionDtos = (map[optionsField] as List)
        .map((e) => MultipleChoiceOptionDto.fromMap(e))
        .toList();

    return QuestionDto(
      id: map[idField],
      text: map[textField],
      image: map[imageField],
      acceptedAnswers:
          (map[acceptedAnswersField] as List).map((e) => e.toString()).toList(),
      testId: map[testIdField],
      type: QuestionTypeDto.values[map[typeField] as int],
      options: optionDtos,
    );
  }

  factory QuestionDto.fromEntity(QuestionEntity entity) {
    return QuestionDto(
      id: entity.id,
      text: entity.text,
      image: entity.image,
      options: entity.options
          .map((e) => MultipleChoiceOptionDto.fromEntity(e))
          .toList(),
      acceptedAnswers: entity.acceptedAnswers,
      testId: entity.testId,
      type: QuestionTypeDto.fromType(entity.type),
    );
  }

  QuestionEntity toEntity() {
    return QuestionEntity(
        id: id,
        image: image,
        testId: testId,
        type: type.toType(),
        acceptedAnswers: acceptedAnswers ?? [],
        text: text,
        options: (options ?? []).map((e) => e.toEntity()).toList());
  }

  Map<String, dynamic> toMap() {
    return {
      testIdField: testId,
      typeField: type.index,
      imageField: image,
      optionsField: options?.map((e) => e.toMap()).toList(),
      acceptedAnswersField: acceptedAnswers,
      textField: text,
      idField: id,
    };
  }

  QuestionDto fromMap(Map<String, dynamic> map) {
    return QuestionDto(
      testId: map[testIdField],
      type: QuestionTypeDto.values[map[typeField] as int],
      image: map[imageField],
      options: (map[optionsField] as List<Map<String, dynamic>>)
          .map((e) => MultipleChoiceOptionDto.fromMap(e))
          .toList(),
      acceptedAnswers: map[acceptedAnswersField],
      text: map[textField],
      id: map[idField],
    );
  }

  QuestionDto copyWith({
    String? id,
    String? testId,
    QuestionTypeDto? type,
    String? image = mockValueForDefault,
    String? text = mockValueForDefault,
    List<String>? acceptedAnswers,
    List<MultipleChoiceOptionDto>? options,
  }) {
    return QuestionDto(
      options: options ?? this.options,
      acceptedAnswers: acceptedAnswers ?? this.acceptedAnswers,
      testId: testId ?? this.testId,
      text: text == mockValueForDefault ? this.text : text,
      type: type ?? this.type,
      image: image == mockValueForDefault ? this.image : image,
      id: id ?? this.id,
    );
  }
}

@HiveType(typeId: 3)
class MultipleChoiceOptionDto {
  @HiveField(0)
  final String? text;

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

  factory MultipleChoiceOptionDto.fromMap(Map<String, dynamic> map) {
    return MultipleChoiceOptionDto(
        text: map[textField], isCorrect: map[isCorrectField]);
  }

  Map<String, dynamic> toMap() {
    return {
      textField: text,
      isCorrectField: isCorrect,
    };
  }
}
