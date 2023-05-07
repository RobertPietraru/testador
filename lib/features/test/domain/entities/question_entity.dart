import 'package:equatable/equatable.dart';

enum QuestionType { multipleChoice, answer }

abstract class QuestionEntity extends Equatable {
  final String testId;
  final QuestionType type;
  final String? image;
  final String? text;

  const QuestionEntity({
    required this.text,
    this.image,
    required this.testId,
    required this.type,
  });
  @override
  List<Object?> get props => [testId, type];
}

class MultipleChoiceQuestionEntity extends QuestionEntity {
  const MultipleChoiceQuestionEntity({
    required super.testId,
    super.type = QuestionType.multipleChoice,
    this.options = const [],
    super.image,
    super.text,
  });
  final List<MultipleChoiceOptionEntity> options;
  @override
  List<Object?> get props => [testId, type, ...options];
}

class TextInputQuestionEntity extends QuestionEntity {
  const TextInputQuestionEntity({
    required super.testId,
    super.type = QuestionType.answer,
    this.acceptedAnswers = const [],
    super.text,
  });

  final List<String> acceptedAnswers;

  @override
  List<Object?> get props => [testId, type, ...acceptedAnswers];
}

class MultipleChoiceOptionEntity extends Equatable {
  final String? text;
  final bool isCorrect;
  const MultipleChoiceOptionEntity(
      {required this.text, this.isCorrect = false});
  @override
  List<Object?> get props => [text, isCorrect];
}
