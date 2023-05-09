import 'package:equatable/equatable.dart';

const mockValueForDefault = 'nothing-to-see-here!@#^';

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

  QuestionEntity copyWith({
    String? testId,
    QuestionType? type,
    String? image = mockValueForDefault,
    String? text = mockValueForDefault,
  }) {
    final old = this;
    if (old is MultipleChoiceQuestionEntity) {
      return MultipleChoiceQuestionEntity(
        options: old.options,
        testId: testId ?? this.testId,
        text: text == mockValueForDefault ? this.text : text,
        type: type ?? this.type,
        image: image == mockValueForDefault ? this.image : image,
      );
    }
    if (old is TextInputQuestionEntity) {
      return TextInputQuestionEntity(
        acceptedAnswers: old.acceptedAnswers,
        testId: testId ?? this.testId,
        text: text == mockValueForDefault ? this.text : text,
        type: type ?? this.type,
        image: image == mockValueForDefault ? this.image : image,
      );
    }

    return MultipleChoiceQuestionEntity(
      testId: testId ?? this.testId,
      text: text == mockValueForDefault ? this.text : text,
      type: type ?? this.type,
      image: image == mockValueForDefault ? this.image : image,
    );
  }
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
    super.image,
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
