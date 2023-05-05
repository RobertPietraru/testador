import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/usecases/edit_test.dart';

import '../failures/test_failures.dart';
import '../usecases/test_usecases.dart';

abstract class TestRepository {
  Future<Either<TestFailure, GetTestsUsecaseResult>> getTests(
      GetTestsUsecaseParams params);
  Future<Either<TestFailure, CreateTestUsecaseResult>> createTest(
      CreateTestUsecaseParams params);
  Future<Either<TestFailure, DeleteTestUsecaseResult>> deleteTest(
      DeleteTestUsecaseParams params);
  Future<Either<TestFailure, SaveTestToDatabaseUsecaseResult>>
      saveTestToDatabase(SaveTestToDatabaseUsecaseParams params);
  Future<Either<TestFailure, EditTestUsecaseResult>> editTest(
      EditTestUsecaseParams params);
  Future<Either<TestFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params);
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params);
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params);
}
