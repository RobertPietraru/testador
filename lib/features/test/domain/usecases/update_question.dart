import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class UpdateQuestionUsecase
    extends UseCase<UpdateQuestionUsecaseResult, UpdateQuestionUsecaseParams> {
  const UpdateQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> call(params) async {
    return testRepository.updateQuestion(params);
  }
}

class UpdateQuestionUsecaseParams extends Params {
  const UpdateQuestionUsecaseParams();
}

class UpdateQuestionUsecaseResult extends Response {
  const UpdateQuestionUsecaseResult();
}
