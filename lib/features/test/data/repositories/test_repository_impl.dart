import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/repositories/test_repository.dart';

import '../../../../core/classes/usecase.dart';
import '../datasources/test_local_datasource.dart';

class TestRepositoryIMPL implements TestRepository {
  const TestRepositoryIMPL(
    this.authRemoteDataSource,
  );

  final TestRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<TestFailure, TestEntity>> changeTestDescription() {
    // TODO: implement changeTestDescription
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> changeTestImage() {
    // TODO: implement changeTestImage
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> changeTestTitle() {
    // TODO: implement changeTestTitle
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> createTest() {
    // TODO: implement createTest
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> deleteQuestion() {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> deleteTest() {
    // TODO: implement deleteTest
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> insertQuestion() {
    // TODO: implement insertQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> saveTestToDatabase() {
    // TODO: implement saveTestToDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> toggleTestPublicity() {
    // TODO: implement toggleTestPublicity
    throw UnimplementedError();
  }

  @override
  Future<Either<TestFailure, TestEntity>> updateQuestion() {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }
}
