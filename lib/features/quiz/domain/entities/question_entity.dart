import 'package:equatable/equatable.dart';
import 'package:testador/core/globals.dart';

enum QuestionType { multipleChoice, answer }

class QuestionEntity extends Equatable {
  final String id;
  final String quizId;
  final QuestionType type;
  final String? image;
  final String? text;
  final List<MultipleChoiceOptionEntity> options;
  final List<String> acceptedAnswers;
  bool get hasMultipleAnswers =>
      options.where((element) => element.isCorrect).length > 1;

  const QuestionEntity({
    required this.id,
    this.options = const [],
    this.acceptedAnswers = const [],
    required this.text,
    this.image,
    required this.quizId,
    required this.type,
  });
  @override
  List<Object?> get props => [
        id,
        quizId,
        type,
        image,
        text,
        ...options,
        ...acceptedAnswers,
      ];

  QuestionEntity copyWith({
    String? id,
    String? quizId,
    QuestionType? type,
    String? image = mockValueForDefault,
    String? text = mockValueForDefault,
    List<String>? acceptedAnswers,
    List<MultipleChoiceOptionEntity>? options,
  }) {
    return QuestionEntity(
      options: options ?? this.options,
      acceptedAnswers: acceptedAnswers ?? this.acceptedAnswers,
      quizId: quizId ?? this.quizId,
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
