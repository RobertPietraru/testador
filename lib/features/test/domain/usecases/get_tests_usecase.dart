import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class GetTestsUsecase
    extends UseCase<GetTestsUsecaseResult, GetTestsUsecaseParams> {
  const GetTestsUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, GetTestsUsecaseResult>> call(params) async {
    return testRepository.getTests(params);
  }
}

class GetTestsUsecaseParams extends Params {
  final String creatorId;
  const GetTestsUsecaseParams({required this.creatorId});
}

class GetTestsUsecaseResult extends Response {
  final List<TestEntity> testEntities;
  const GetTestsUsecaseResult({required this.testEntities});
}
