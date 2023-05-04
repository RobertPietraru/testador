import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/repositories/test_repository.dart';
import 'package:testador/features/test/domain/usecases/update_question.dart';
import 'package:testador/features/test/domain/usecases/toggle_test_publicity.dart';
import 'package:testador/features/test/domain/usecases/save_test_to_database.dart';
import 'package:testador/features/test/domain/usecases/insert_question.dart';
import 'package:testador/features/test/domain/usecases/delete_test.dart';
import 'package:testador/features/test/domain/usecases/delete_question.dart';
import 'package:testador/features/test/domain/usecases/create_test.dart';
import 'package:testador/features/test/domain/usecases/change_test_title.dart';
import 'package:testador/features/test/domain/usecases/change_test_image.dart';
import 'package:testador/features/test/domain/usecases/change_test_description.dart';

import '../../../../core/classes/usecase.dart';
import '../datasources/test_local_datasource.dart';

class TestRepositoryIMPL implements TestRepository {
  const TestRepositoryIMPL(
    this.authRemoteDataSource,
  );

  final TestRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<TestFailure, ChangeTestDescriptionUsecaseResult>>
      changeTestDescription(ChangeTestDescriptionUsecaseParams params) {
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, ChangeTestImageUsecaseResult>> changeTestImage(
      ChangeTestImageUsecaseParams params) {
    // TODO: implement changeTestImage
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, ChangeTestTitleUsecaseResult>> changeTestTitle(
      ChangeTestTitleUsecaseParams params) {
    // TODO: implement changeTestTitle
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, CreateTestUsecaseResult>> createTest(
      CreateTestUsecaseParams params) {
    // TODO: implement createTest
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, DeleteTestUsecaseResult>> deleteTest(
      DeleteTestUsecaseParams params) {
    // TODO: implement deleteTest
    throw UnimplementedError();
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
  Future<Either<TestFailure, ToggleTestPublicityUsecaseResult>>
      toggleTestPublicity(ToggleTestPublicityUsecaseParams params) {
    // TODO: implement toggleTestPublicity
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params) {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }
}
