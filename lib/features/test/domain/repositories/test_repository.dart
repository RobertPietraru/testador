import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';

abstract class TestRepository {
  Future<Either<TestFailure, TestEntity>> createTest();
  Future<Either<TestFailure, TestEntity>> deleteTest();
  Future<Either<TestFailure, TestEntity>> changeTestImage();
  Future<Either<TestFailure, TestEntity>> toggleTestPublicity();
  Future<Either<TestFailure, TestEntity>> changeTestTitle();
  Future<Either<TestFailure, TestEntity>> changeTestDescription();
}
