import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testador/features/quiz/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/quiz/data/dtos/quiz/quiz_dto.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';

import '../../domain/usecases/quiz_usecases.dart';

abstract class QuizRemoteDataSource {
  Future<void> syncToDatabase(SyncQuizUsecaseParams params);
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params);
  Future<List<QuizEntity>> getQuizes(GetQuizesUsecaseParams params);
}

class QuizRemoteDataSourceIMPL implements QuizRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> syncToDatabase(SyncQuizUsecaseParams params) async {
    final quiz = DraftDto.fromEntity(params.draft);

    await db.collection('quizes').doc(quiz.id).set(quiz.toMap());
  }

  @override
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params) {
    throw UnimplementedError();
  }

  @override
  Future<List<QuizEntity>> getQuizes(GetQuizesUsecaseParams params) async {
    final snap = await db
        .collection(QuizDto.collection)
        .where(QuizDto.creatorField, isEqualTo: params.creatorId)
        .get();
    return snap.docs.map((e) => QuizDto.fromMap(e.data()).toEntity()).toList();
  }
}
