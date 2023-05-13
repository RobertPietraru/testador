import 'dart:io';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import '../../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../repositories/test_repository.dart';

class UpdateTestImageUsecase extends UseCase<UpdateTestImageUsecaseResult,
    UpdateTestImageUsecaseParams> {
  const UpdateTestImageUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, UpdateTestImageUsecaseResult>> call(params) async {
    return testRepository.updateTestImage(params);
  }
}

class UpdateTestImageUsecaseParams extends Params {
  final DraftEntity test;
  final File image;
  const UpdateTestImageUsecaseParams({required this.test, required this.image});
}

class UpdateTestImageUsecaseResult extends Response {
  final DraftEntity test;
  const UpdateTestImageUsecaseResult({required this.test});
}
