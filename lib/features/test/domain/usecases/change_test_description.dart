import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class ChangeTestDescriptionUsecase extends UseCase<
    ChangeTestDescriptionUsecaseResult, ChangeTestDescriptionUsecaseParams> {
  const ChangeTestDescriptionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, ChangeTestDescriptionUsecaseResult>> call(
      params) async {
    return testRepository.changeTestDescription(params);
  }
}

class ChangeTestDescriptionUsecaseParams extends Params {
  const ChangeTestDescriptionUsecaseParams();
}

class ChangeTestDescriptionUsecaseResult extends Response {
  const ChangeTestDescriptionUsecaseResult();
}
