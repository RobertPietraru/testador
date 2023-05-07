import '../entities/test_entity.dart';
import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class DeleteQuestionUsecase
    extends UseCase<DeleteQuestionUsecaseResult, DeleteQuestionUsecaseParams> {
  const DeleteQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> call(params) async {
    return testRepository.deleteQuestion(params);
  }
}

class DeleteQuestionUsecaseParams extends Params {
  final TestEntity test;
  final int index;
  const DeleteQuestionUsecaseParams({required this.test, required this.index});
}

class DeleteQuestionUsecaseResult extends Response {
  final TestEntity testEntity;
  const DeleteQuestionUsecaseResult({required this.testEntity});
}
