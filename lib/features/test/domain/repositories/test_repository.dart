import 'package:dartz/dartz.dart';

import '../failures/test_failures.dart';
import '../usecases/usecases.dart';

abstract class TestRepository {
  Future<Either<TestFailure, CreateTestUsecaseResult>> createTest(
      CreateTestUsecaseParams params);
  Future<Either<TestFailure, DeleteTestUsecaseResult>> deleteTest(
      DeleteTestUsecaseParams params);
  Future<Either<TestFailure, SaveTestToDatabaseUsecaseResult>>
      saveTestToDatabase(SaveTestToDatabaseUsecaseParams params);
  Future<Either<TestFailure, ChangeTestTitleUsecaseResult>> changeTestTitle(
      ChangeTestTitleUsecaseParams params);
  Future<Either<TestFailure, ToggleTestPublicityUsecaseResult>>
      toggleTestPublicity(ToggleTestPublicityUsecaseParams params);
  Future<Either<TestFailure, ChangeTestDescriptionUsecaseResult>>
      changeTestDescription(ChangeTestDescriptionUsecaseParams params);
  Future<Either<TestFailure, ChangeTestImageUsecaseResult>> changeTestImage(
      ChangeTestImageUsecaseParams params);
  Future<Either<TestFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params);
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params);
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params);
}
