import 'package:equatable/equatable.dart';
import 'package:testador/core/globals.dart';
import 'package:testador/features/quiz/domain/entities/question_entity.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';

class DraftEntity extends Equatable {
  final String id;
  final String? title;
  final bool isPublic;
  final String creatorId;
  final String? imageId;
  final List<QuestionEntity> questions;

  const DraftEntity({
    required this.questions,
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageId,
    required this.id,
  });

  factory DraftEntity.fromEntity(QuizEntity quiz) {
    return DraftEntity(
      questions: quiz.questions,
      title: quiz.title,
      isPublic: quiz.isPublic,
      creatorId: quiz.creatorId,
      imageId: quiz.imageId,
      id: quiz.id,
    );
  }
  @override
  List<Object?> get props =>
      [id, title, isPublic, creatorId, imageId, ...questions];
  DraftEntity copyWith({
    String? id,
    String? title = mockValueForDefault,
    bool? isPublic,
    String? creatorId,
    String? imageId = mockValueForDefault,
    List<QuestionEntity>? questions,
  }) {
    return DraftEntity(
      questions: questions ?? this.questions,
      isPublic: isPublic ?? this.isPublic,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      title: title == mockValueForDefault ? this.title : title,
      imageId: imageId == mockValueForDefault ? this.imageId : imageId,
    );
  }

  QuizEntity toQuiz() {
    return QuizEntity(
      questions: questions,
      title: title,
      isPublic: isPublic,
      creatorId: creatorId,
      imageId: imageId,
      id: id,
    );
  }
}
