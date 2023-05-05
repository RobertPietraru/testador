import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class CreateTestUsecase
    extends UseCase<CreateTestUsecaseResult, CreateTestUsecaseParams> {
  const CreateTestUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, CreateTestUsecaseResult>> call(params) async {
    return testRepository.createTest(params);
  }
}

class CreateTestUsecaseParams extends Params {
  final String creatorId;
  const CreateTestUsecaseParams({
    required this.creatorId,
  });
}

class CreateTestUsecaseResult extends Response {
  final TestEntity testEntity;
  const CreateTestUsecaseResult({required this.testEntity});
}
