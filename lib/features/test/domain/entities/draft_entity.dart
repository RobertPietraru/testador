import 'package:equatable/equatable.dart';
import 'package:testador/core/globals.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
//TODO: add description

class DraftEntity extends Equatable {
  final String id;
  final String? title;
  final bool isPublic;
  final String creatorId;
  final String? imageUrl;
  final List<QuestionEntity> questions;

  const DraftEntity({
    required this.questions,
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageUrl,
    required this.id,
  });

  factory DraftEntity.fromEntity(DraftEntity draft) {
    return DraftEntity(
      questions: draft.questions,
      title: draft.title,
      isPublic: draft.isPublic,
      creatorId: draft.creatorId,
      imageUrl: draft.imageUrl,
      id: draft.id,
    );
  }
  @override
  List<Object?> get props =>
      [id, title, isPublic, creatorId, imageUrl, ...questions];
  DraftEntity copyWith({
    String? id,
    String? title = mockValueForDefault,
    bool? isPublic,
    String? creatorId,
    String? imageUrl = mockValueForDefault,
    List<QuestionEntity>? questions,
  }) {
    return DraftEntity(
      questions: questions ?? this.questions,
      isPublic: isPublic ?? this.isPublic,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      title: title == mockValueForDefault ? this.title : title,
      imageUrl: imageUrl == mockValueForDefault ? this.imageUrl : imageUrl,
    );
  }
}
