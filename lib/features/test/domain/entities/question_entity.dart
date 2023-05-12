import 'package:equatable/equatable.dart';

const mockValueForDefault = 'nothing-to-see-here!@#^';

enum QuestionType { multipleChoice, answer }

class QuestionEntity extends Equatable {
  final String id;
  final String testId;
  final QuestionType type;
  final String? image;
  final String? text;
  final List<MultipleChoiceOptionEntity> options;
  final List<String> acceptedAnswers;

  const QuestionEntity({
    required this.id,
    this.options = const [],
    this.acceptedAnswers = const [],
    required this.text,
    this.image,
    required this.testId,
    required this.type,
  });
  @override
  List<Object?> get props => [
        id,
        testId,
        type,
        image,
        text,
        ...options,
        ...acceptedAnswers,
      ];

  QuestionEntity copyWith({
    String? id,
    String? testId,
    QuestionType? type,
    String? image = mockValueForDefault,
    String? text = mockValueForDefault,
    List<String>? acceptedAnswers,
    List<MultipleChoiceOptionEntity>? options,
  }) {
    return QuestionEntity(
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

class MultipleChoiceOptionEntity extends Equatable {
  final String? text;
  final bool isCorrect;
  const MultipleChoiceOptionEntity(
      {required this.text, this.isCorrect = false});
  @override
  List<Object?> get props => [text, isCorrect];
}
