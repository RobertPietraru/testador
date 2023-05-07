import 'package:equatable/equatable.dart';

enum QuestionType { multipleChoice, answer }

abstract class QuestionEntity extends Equatable {
  final String id;
  final String testId;
  final QuestionType type;
  final String? image;

  const QuestionEntity({
    this.image,
    required this.id,
    required this.testId,
    required this.type,
  });
  @override
  List<Object?> get props => [id, testId, type];
}

class MultipleChoiceQuestionEntity extends QuestionEntity {
  const MultipleChoiceQuestionEntity({
    required super.id,
    required super.testId,
    super.type = QuestionType.multipleChoice,
    required this.options,
  });
  final List<MultipleChoiceOptionEntity> options;
  @override
  List<Object?> get props => [id, testId, type, ...options];
}

class TextInputQuestionEntity extends QuestionEntity {
  const TextInputQuestionEntity({
    required super.id,
    required super.testId,
    required super.type,
    required this.acceptedAnswers,
  });

  final List<String> acceptedAnswers;

  @override
  List<Object?> get props => [id, testId, type, ...acceptedAnswers];
}

class MultipleChoiceOptionEntity extends Equatable {
  final String text;
  final bool isCorrect;
  const MultipleChoiceOptionEntity(
      {required this.text, required this.isCorrect});
  @override
  List<Object?> get props => [text, isCorrect];
}
