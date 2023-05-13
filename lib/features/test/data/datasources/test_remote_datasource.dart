import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testador/features/test/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

abstract class TestRemoteDataSource {
  Future<void> syncToDatabase(SyncTestUsecaseParams params);
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params);
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params);
}

class TestRemoteDataSourceIMPL implements TestRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> syncToDatabase(SyncTestUsecaseParams params) async {
    //TODO: fix
    final test = DraftDto.fromEntity(params.draft);

    await db.collection('tests').doc(test.id).set(test.toMap());
  }

  @override
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params) {
    // TODO: implement getTestById
    throw UnimplementedError();
  }

  @override
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params) async {
    final snap = await db
        .collection(TestDto.collection)
        .where(TestDto.creatorField, isEqualTo: params.creatorId)
        .get();
    return snap.docs.map((e) => TestDto.fromMap(e.data()).toEntity()).toList();
  }
}
