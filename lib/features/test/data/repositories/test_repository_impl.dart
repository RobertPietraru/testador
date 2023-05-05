import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/edit_test.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';
import '../../domain/repositories/test_repository.dart';

class TestRepositoryIMPL implements TestRepository {
  const TestRepositoryIMPL(
    this.testLocalDataSource,
  );

  final TestLocalDataSource testLocalDataSource;

  @override
  Future<Either<TestFailure, CreateTestUsecaseResult>> createTest(
      CreateTestUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.createTest(params);
      return Right(CreateTestUsecaseResult(testEntity: testEntity));
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
      DeleteQuestionUsecaseParams params) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
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
      InsertQuestionUsecaseParams params) {
    // TODO: implement insertQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, SaveTestToDatabaseUsecaseResult>>
      saveTestToDatabase(SaveTestToDatabaseUsecaseParams params) {
    // TODO: implement saveTestToDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params) {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, EditTestUsecaseResult>> editTest(
      EditTestUsecaseParams params) async {
    try {
      final testEntity = await testLocalDataSource.editTest(params);
      return Right(EditTestUsecaseResult(testEntity: testEntity));
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
      final tests = await testLocalDataSource.getTests(params);
      return Right(GetTestsUsecaseResult(testEntities: tests));
    } on FirebaseException catch (e) {
      return Left(TestUnknownFailure(code: e.code));
    } on TestFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(TestUnknownFailure());
    }
  }
}
