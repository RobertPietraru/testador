import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class ToggleTestPublicityUsecase extends UseCase<
    ToggleTestPublicityUsecaseResult, ToggleTestPublicityUsecaseParams> {
  const ToggleTestPublicityUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, ToggleTestPublicityUsecaseResult>> call(
      params) async {
    return testRepository.toggleTestPublicity(params);
  }
}

class ToggleTestPublicityUsecaseParams extends Params {
  const ToggleTestPublicityUsecaseParams();
}

class ToggleTestPublicityUsecaseResult extends Response {
  const ToggleTestPublicityUsecaseResult();
}
