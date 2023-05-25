import 'package:equatable/equatable.dart';
import 'package:testador/core/globals.dart';
import 'package:testador/features/quiz/domain/entities/question_entity.dart';

class QuizEntity extends Equatable {
  final String id;
  final String? title;
  final bool isPublic;
  final String creatorId;
  final String? imageId;
  final List<QuestionEntity> questions;

  const QuizEntity({
    required this.questions,
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageId,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [id, title, isPublic, creatorId, imageId, ...questions];
  QuizEntity copyWith({
    String? id,
    String? title = mockValueForDefault,
    bool? isPublic,
    String? creatorId,
    String? imageId = mockValueForDefault,
    List<QuestionEntity>? questions,
  }) {
    return QuizEntity(
      questions: questions ?? this.questions,
      isPublic: isPublic ?? this.isPublic,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      title: title == mockValueForDefault ? this.title : title,
      imageId: imageId == mockValueForDefault ? this.imageId : imageId,
    );
  }
}
