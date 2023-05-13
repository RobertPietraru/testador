import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/usecases/draft/delete_draft_by_id.dart';

import '../failures/test_failures.dart';
import '../usecases/test_usecases.dart';

abstract class TestRepository {
  Future<Either<TestFailure, GetDraftByIdUsecaseResult>> getDraftById(
      GetDraftByIdUsecaseParams params);
  Future<Either<TestFailure, GetTestByIdUsecaseResult>> getTestById(
      GetTestByIdUsecaseParams params);
  Future<Either<TestFailure, GetTestsUsecaseResult>> getTests(
      GetTestsUsecaseParams params);
  Future<Either<TestFailure, UpdateQuestionImageUsecaseResult>>
      updateQuestionImage(UpdateQuestionImageUsecaseParams params);
  Future<Either<TestFailure, UpdateTestImageUsecaseResult>> updateTestImage(
      UpdateTestImageUsecaseParams params);
  Future<Either<TestFailure, SyncTestUsecaseResult>> syncTest(
      SyncTestUsecaseParams params);

  Future<Either<TestFailure, CreateDraftUsecaseResult>> createTest(
      CreateDraftUsecaseParams params);
  Future<Either<TestFailure, EditTestUsecaseResult>> editTest(
      UpdateTestUsecaseParams params);

  Future<Either<TestFailure, MoveQuestionUsecaseResult>> moveQuestion(
      MoveQuestionUsecaseParams params);
  Future<Either<TestFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params);
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params);
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params);

  Future<Either<TestFailure, DeleteDraftByIdUsecaseResult>> deleteDraftById(
      DeleteDraftByIdUsecaseParams params);
}
