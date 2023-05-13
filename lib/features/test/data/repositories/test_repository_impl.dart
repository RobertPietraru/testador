import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/data/datasources/test_remote_datasource.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';
import '../../domain/repositories/test_repository.dart';

class TestRepositoryIMPL implements TestRepository {
  const TestRepositoryIMPL(
    this.testLocalDataSource,
    this.testRemoteDataSource,
  );

  final TestLocalDataSource testLocalDataSource;
  final TestRemoteDataSource testRemoteDataSource;

  @override
  Future<Either<TestFailure, CreateDraftUsecaseResult>> createTest(
      CreateDraftUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.createDraft(params);
      return Right(CreateDraftUsecaseResult(draft: testEntity));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.deleteQuestion(params);
      return Right(DeleteQuestionUsecaseResult(testEntity: testEntity));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, DeleteTestUsecaseResult>> deleteTest(
      DeleteTestUsecaseParams params) async {
    try {
      await testLocalDataSource.deleteTest(params);
      return const Right(DeleteTestUsecaseResult());
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params) async {
    try {
      final response = await testLocalDataSource.insertQuestion(params);
      return Right(InsertQuestionUsecaseResult(draft: response));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.updateQuestion(params);
      return Right(UpdateQuestionUsecaseResult(testEntity: testEntity));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, EditTestUsecaseResult>> editTest(
      UpdateTestUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.updateTest(params);
      return Right(EditTestUsecaseResult(test: testEntity));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, GetTestsUsecaseResult>> getTests(
      GetTestsUsecaseParams params) async {
    try {
      final tests = await testRemoteDataSource.getTests(params);
      return Right(GetTestsUsecaseResult(testEntities: tests));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } on Error catch (_) {
      print(_);
      print(_.stackTrace);
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, GetDraftByIdUsecaseResult>> getDraftById(
      GetDraftByIdUsecaseParams params) async {
    try {
      final test = await testLocalDataSource.getDraftById(params);
      return Right(GetDraftByIdUsecaseResult(testEntity: test));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, MoveQuestionUsecaseResult>> moveQuestion(
      MoveQuestionUsecaseParams params) async {
    try {
      final test = await testLocalDataSource.moveQuestion(params);
      return Right(MoveQuestionUsecaseResult(test: test));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, UpdateQuestionImageUsecaseResult>>
      updateQuestionImage(UpdateQuestionImageUsecaseParams params) async {
    try {
      final test = await testLocalDataSource.updateQuestionImage(params);
      return Right(UpdateQuestionImageUsecaseResult(test: test));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, UpdateTestImageUsecaseResult>> updateTestImage(
      UpdateTestImageUsecaseParams params) async {
    try {
      final test = await testLocalDataSource.updateTestImage(params);
      return Right(UpdateTestImageUsecaseResult(test: test));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, SyncTestUsecaseResult>> syncTest(
      SyncTestUsecaseParams params) async {
    try {
      testRemoteDataSource.syncToDatabase(params);
      return const Right(SyncTestUsecaseResult());
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }

  @override
  Future<Either<TestFailure, GetTestByIdUsecaseResult>> getTestById(
      GetTestByIdUsecaseParams params) async {
    try {
      final test = await testRemoteDataSource.getTestById(params);
      return Right(GetTestByIdUsecaseResult(testEntity: test));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }
}
