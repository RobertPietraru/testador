import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:testador/features/test/domain/usecases/edit_test.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/test_entity.dart';
import '../../domain/failures/test_failures.dart';
import '../../domain/usecases/test_usecases.dart';

abstract class TestLocalDataSource {
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params);
  Future<TestEntity> createTest(CreateTestUsecaseParams params);
  Future<void> deleteTest(DeleteTestUsecaseParams params);

  Future<TestEntity> editTest(EditTestUsecaseParams params);
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params);
  Future<TestEntity> insertQuestion(InsertQuestionUsecaseParams params);
  Future<TestEntity> deleteQuestion(DeleteQuestionUsecaseParams params);
  Future<TestEntity> updateQuestion(UpdateQuestionUsecaseParams params);
}

class TestLocalDataSourceIMPL implements TestLocalDataSource {
  TestLocalDataSourceIMPL();

  final Box<TestDto> testsBox = Hive.box<TestDto>(TestDto.hiveBoxName);

  @override
  Future<TestEntity> createTest(CreateTestUsecaseParams params) async {
    final id = const Uuid().v1();
    final testDto = TestDto(
      creatorId: params.creatorId,
      id: id,
      imageUrl: null,
      isPublic: false,
      title: null,
    );
    testsBox.put(id, testDto);
    return testDto;
  }

  @override
  Future<TestEntity> deleteQuestion(DeleteQuestionUsecaseParams params) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTest(DeleteTestUsecaseParams params) async {
    await testsBox.delete(params.testId);
  }

  @override
  Future<TestEntity> insertQuestion(InsertQuestionUsecaseParams params) {
    throw UnimplementedError();
  }

  @override
  Future<TestEntity> updateQuestion(UpdateQuestionUsecaseParams params) {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }

  @override
  Future<TestEntity> editTest(EditTestUsecaseParams params) async {
    final test = testsBox.get(params.testId);

    if (test == null) throw const TestNotFoundFailure();
    final newTest = TestDto(
      title: params.title,
      isPublic: params.isPublic ?? test.isPublic,
      creatorId: test.creatorId,
      imageUrl: params.imageUrl ?? test.imageUrl,
      id: params.testId,
    );
    testsBox.put(newTest.id, newTest);
    return newTest;
  }

  @override
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params) async {
    return testsBox.values
        .where((element) => element.creatorId == params.creatorId)
        .toList();
  }

  @override
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params) async {
    final test = testsBox.get(params.testId);
    if (test == null) {
      throw const TestNotFoundFailure();
    }
    return test;
  }
}
