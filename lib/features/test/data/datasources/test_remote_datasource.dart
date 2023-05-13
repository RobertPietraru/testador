import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testador/features/test/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

abstract class QuizRemoteDataSource {
  Future<void> syncToDatabase(SyncQuizUsecaseParams params);
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params);
  Future<List<QuizEntity>> getQuizs(GetQuizsUsecaseParams params);
}

class QuizRemoteDataSourceIMPL implements QuizRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> syncToDatabase(SyncQuizUsecaseParams params) async {
    //TODO: fix
    final quiz = DraftDto.fromEntity(params.draft);

    await db.collection('tests').doc(quiz.id).set(quiz.toMap());
  }

  @override
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params) {
    // TODO: implement getQuizById
    throw UnimplementedError();
  }

  @override
  Future<List<QuizEntity>> getQuizs(GetQuizsUsecaseParams params) async {
    final snap = await db
        .collection(QuizDto.collection)
        .where(QuizDto.creatorField, isEqualTo: params.creatorId)
        .get();
    return snap.docs.map((e) => QuizDto.fromMap(e.data()).toEntity()).toList();
  }
}
