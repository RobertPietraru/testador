import 'package:equatable/equatable.dart';

enum QuestionType { multipleChoice, answer }

class QuestionEntity extends Equatable {
  final String id;
  final String testId;
  final QuestionType type;

  const QuestionEntity({
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
    required super.type,
    required this.options,
  });
  final List<MultipleChoiceOption> options;
  @override
  List<Object?> get props => [id, testId, type, ...options];
}

class MultipleChoiceOption extends Equatable {
  final String text;
  final bool isCorrect;
  const MultipleChoiceOption({required this.text, required this.isCorrect});
  @override
  List<Object?> get props => [text, isCorrect];
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
