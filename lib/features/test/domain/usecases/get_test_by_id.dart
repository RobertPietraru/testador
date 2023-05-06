import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class GetTestByIdUsecase
    extends UseCase<GetTestByIdUsecaseResult, GetTestByIdUsecaseParams> {
  const GetTestByIdUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, GetTestByIdUsecaseResult>> call(params) async {
    return testRepository.getTestById(params);
  }
}

class GetTestByIdUsecaseParams extends Params {
  final String testId;
  const GetTestByIdUsecaseParams({required this.testId});
}

class GetTestByIdUsecaseResult extends Response {
  final TestEntity testEntity;
  const GetTestByIdUsecaseResult({required this.testEntity});
}
